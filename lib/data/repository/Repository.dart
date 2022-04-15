import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_app/data/dto/PatientKeysDTO.dart';
import 'package:flutter_app/domain/model/Certificate.dart';
import 'package:flutter_app/domain/model/SignedCertificate.dart';
import 'package:flutter_app/impfy.g.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openpgp/openpgp.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:eth_sig_util/eth_sig_util.dart';

// TODO: Convert to singleton
class Repository {
  final FlutterSecureStorage _localStorage = const FlutterSecureStorage();
  late Impfy _client;
  final EthereumAddress _contractAddress =
      EthereumAddress.fromHex('0xb58d3d11966CCeB725e39C3d6D0d383Bf3F1cec3');
  final String _rpcUrl = 'https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161';

  Repository() {
    var client = Web3Client(_rpcUrl, Client());
    _client = Impfy(address: _contractAddress, client: client);
  }

  Future<List<SignedCertificate>> getCertificates() async {
    String passphrase = '';

    // ethereum privat key fetched, and public key generated with credentials
    String ethPrivateKey = (await _localStorage.read(key: 'ethPrivateKey'))!;
    Credentials credentials = EthPrivateKey.fromHex(ethPrivateKey);
    // EthereumAddress address = await credentials.extractAddress();
    // FIXME: Remove
    EthereumAddress address = EthereumAddress.fromHex('0x94e5999Dea8b2369fd313C34EE4ab2217E6F7B10');

    // result structure currently unknown
    var response = (await _client.getCertificates(address));
    var certificates = response
        .map((element) => List.from(element))
        .map((element) => _decryptCertificate(element, passphrase));

    return (await Future.wait(certificates)).whereType<SignedCertificate>().toList();
  }

  Future<void> createCertificate(Certificate certificate, PatientKeysDTO patientKeys) async {
    String pgpDoctorPublicKey = (await _localStorage.read(key: 'pgpPublicKey'))!;
    String ethPrivateKey = (await _localStorage.read(key: 'ethPrivateKey'))!;
    Credentials credentials = EthPrivateKey.fromHex(ethPrivateKey);
    String hash = certificate.hashCode.toString();
    String signedHash = EthSigUtil.signMessage(
        privateKey: ethPrivateKey, message: Uint8List.fromList(hash.codeUnits));
    String encryptedCertificate = await certificate.encrypt(pgpDoctorPublicKey, patientKeys.pgpKey);
    _client.addCertificate(
        encryptedCertificate, signedHash, EthereumAddress.fromHex(patientKeys.ethAddress),
        credentials: credentials);
  }

  Future<SignedCertificate?> _decryptCertificate(List<dynamic> data, String passphrase) async {
    String encryptedCertificate = data.first as String;
    String signedHash = data.last as String;
    String privateKey = (await _localStorage.read(key: 'pgpPrivateKey'))!;
    try {
      String certificateJson = await OpenPGP.decrypt(encryptedCertificate, privateKey, passphrase);
      Certificate certificate = Certificate.fromJson(json.decode(certificateJson));
      return SignedCertificate(certificate: certificate, signedHash: signedHash);
    } catch (e) {
      return null;
    }
  }
}
