import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_app/data/api/ipfs.dart';
import 'package:flutter_app/data/dto/certificate_dto.dart';
import 'package:flutter_app/data/dto/patient_dto.dart';
import 'package:flutter_app/domain/model/Certificate.dart';
import 'package:flutter_app/domain/model/SignedCertificate.dart';
import 'package:flutter_app/impfy.g.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openpgp/openpgp.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:eth_sig_util/eth_sig_util.dart';

class Repository {
  static final Repository _instance = Repository._internal();
  final IPFS _ipfs = IPFS();
  final FlutterSecureStorage _secureStore = const FlutterSecureStorage();
  final String _passphrase = '';
  late final Impfy _impfy;

  factory Repository() {
    return _instance;
  }

  Repository._internal() {
    String hexAddress = '0x871e088C3307f726FDD7BAC1370482F57B42eBDC';
    EthereumAddress contractAddress = EthereumAddress.fromHex(hexAddress);
    String rpcUrl =
        'https://eth-rinkeby.alchemyapi.io/v2/yCa_KizxtugRrLnI4Hl7wTwYZZHKJkrc';
    var client = Web3Client(rpcUrl, Client());
    _impfy = Impfy(address: contractAddress, client: client);
  }

  Future<EthPrivateKey> _getCredentials() async {
    String ethPrivateKey = (await _secureStore.read(key: 'ethPrivateKey'))!;
    return EthPrivateKey.fromHex(ethPrivateKey);
  }

  Future<List<SignedCertificate>> getCertificates() async {
    EthPrivateKey credentials = await _getCredentials();

    var response = (await _impfy.getCertificates(credentials.address));
    var certificates = response
        .map((element) => String.fromCharCodes(element))
        .map((element) => _getCertificateFromIPFS(element));

    return (await Future.wait(certificates))
        .whereType<SignedCertificate>()
        .toList();
  }

  Future<SignedCertificate?> _getCertificateFromIPFS(String ipfsHash) async {
    String ipfsResult = await _ipfs.getCertificate(ipfsHash);
    CertificateDTO certificateDTO =
        CertificateDTO.fromJson(jsonDecode(ipfsResult));
    return _decryptCertificate(certificateDTO, _passphrase, ipfsHash);
  }

  Future<void> createCertificate(
    Certificate certificate,
    PatientDTO patient,
  ) async {
    String ethPrivateKey = (await _secureStore.read(key: 'ethPrivateKey'))!;
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
    String privateKey = (await _secureStore.read(key: 'pgpPrivateKey'))!;
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

  Future<bool> isValidCertificate(String doctor, String ipfsHash) async {
    EthereumAddress doctorAddress = EthereumAddress.fromHex(doctor);
    Uint8List data = Uint8List.fromList(ipfsHash.codeUnits);

    BigInt blockNumber = await _impfy.getDoctorBlockNumber(doctorAddress);
    BlockNum block = BlockNum.exact(blockNumber.toInt() - 1);

    return await _impfy.certificateExists(data, atBlock: block);
  }
}
