import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter_app/data/api/impfy.g.dart';
import 'package:flutter_app/data/api/ipfs.dart';
import 'package:flutter_app/data/dto/certificate_dto.dart';
import 'package:flutter_app/data/dto/patient_dto.dart';
import 'package:flutter_app/domain/authentication/key_storage.dart';
import 'package:flutter_app/domain/model/certificate.dart';
import 'package:flutter_app/domain/model/signed_certificate.dart';
import 'package:http/http.dart';
import 'package:openpgp/openpgp.dart';
import 'package:web3dart/web3dart.dart';

class Repository {
  late final Impfy _impfy;
  final KeyStorage _keyStorage = KeyStorage();
  static final Repository _instance = Repository._internal();
  final IPFS _ipfs = IPFS();
  final String _rpcUrl = 'https://eth-rinkeby.alchemyapi.io/v2/yCa_KizxtugRrLnI4Hl7wTwYZZHKJkrc';
  final String _contractAddress = '0x64C99DF4eC727941e5C959Aaf0A3dF0381312a14';
  final String _passphrase = '';

  factory Repository() {
    return _instance;
  }

  Repository._internal() {
    EthereumAddress contractAddress = EthereumAddress.fromHex(_contractAddress);
    var client = Web3Client(_rpcUrl, Client());
    _impfy = Impfy(address: contractAddress, client: client);
  }

  Future<EthPrivateKey> _getCredentials() async {
    String ethPrivateKey = (await _keyStorage.getEthPrivateKey())!;
    return EthPrivateKey.fromHex(ethPrivateKey);
  }

  Future<List<SignedCertificate>> getPatientCertificates() async {
    EthPrivateKey credentials = await _getCredentials();

    var response = await _impfy.getPatientCertificates(credentials.address);
    return _parseCertificates(response);
  }

  Future<List<SignedCertificate>> getDoctorCertificates() async {
    EthPrivateKey credentials = await _getCredentials();

    var response = await _impfy.getDoctorCertificates(credentials.address);
    return _parseCertificates(response);
  }

  Future<List<SignedCertificate>> _parseCertificates(List<Uint8List> response) async {
    var certificates = response
        .map((element) => String.fromCharCodes(element))
        .map((element) => _getCertificateFromIPFS(element));

    return (await Future.wait(certificates)).whereType<SignedCertificate>().toList();
  }

  Future<SignedCertificate?> _getCertificateFromIPFS(String ipfsHash) async {
    CertificateDTO certificateDTO = await _getCertificateDTOFromIPFS(ipfsHash);
    return _decryptCertificate(certificateDTO, _passphrase, ipfsHash);
  }

  Future<CertificateDTO> _getCertificateDTOFromIPFS(String ipfsHash) async {
    String ipfsResult = await _ipfs.getCertificate(ipfsHash);
    return CertificateDTO.fromJson(jsonDecode(ipfsResult));
  }

  Future<void> createCertificate(
    Certificate certificate,
    PatientDTO patient,
  ) async {
    String ethPrivateKey = (await _keyStorage.getEthPrivateKey())!;
    EthPrivateKey credentials = EthPrivateKey.fromHex(ethPrivateKey);
    String hash = md5.convert(certificate.toString().codeUnits).toString();
    String signedHash = EthSigUtil.signMessage(
      privateKey: ethPrivateKey,
      message: Uint8List.fromList(hash.codeUnits),
    );
    String encryptedCertificate = await certificate.encrypt(
      patient.pgpPublicKey,
    );
    CertificateDTO certificateDTO = CertificateDTO(
      encryptedCertificate: encryptedCertificate,
      signedHash: signedHash,
    );
    String ipfsHash = await _ipfs.postCertificate(certificateDTO.toString());
    _impfy.addCertificate(
      Uint8List.fromList(ipfsHash.codeUnits),
      EthereumAddress.fromHex(patient.ethAddress),
      credentials: credentials,
    );
  }

  Future<SignedCertificate?> _decryptCertificate(
    CertificateDTO certificateDTO,
    String passphrase,
    String ipfsHash,
  ) async {
    String privateKey = (await _keyStorage.getPgpPrivateKey())!;
    try {
      String certificateJson = await OpenPGP.decrypt(
        certificateDTO.encryptedCertificate,
        privateKey,
        passphrase,
      );
      Certificate certificate = Certificate.fromJson(
        json.decode(certificateJson),
      );
      return SignedCertificate(
        certificate: certificate,
        signedHash: certificateDTO.signedHash,
        ipfsHash: ipfsHash,
      );
    } catch (e) {
      return null;
    }
  }

  Future<bool> isDoctor(String doctor) async {
    EthereumAddress doctorAddress = EthereumAddress.fromHex(doctor);
    return await _impfy.isDoctor(doctorAddress);
  }

  Future<bool> isValidCertificate(String ipfsHash, String signedHash) async {
    Uint8List data = Uint8List.fromList(ipfsHash.codeUnits);
    if (!(await _impfy.certificateExists(data))) return false;
    CertificateDTO certificateDTO = await _getCertificateDTOFromIPFS(ipfsHash);
    return certificateDTO.signedHash == signedHash;
  }
}
