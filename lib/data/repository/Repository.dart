import 'dart:convert';

import 'package:flutter_app/domain/model/Certificate.dart';
import 'package:flutter_app/impfy.g.dart';
import 'package:openpgp/openpgp.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:eth_sig_util/eth_sig_util.dart';

// TODO: Convert to singleton
class Repository {
  late String _privateKey;
  late Impfy _client;
  late EthPrivateKey _credentials;
  final EthereumAddress _contractAddress =
      EthereumAddress.fromHex('0xb58d3d11966CCeB725e39C3d6D0d383Bf3F1cec3');
  final String _rpcUrl = 'https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161';

  Repository(String privateKey) {
    _privateKey = privateKey;
    _credentials = EthPrivateKey.fromHex(_privateKey);
    var client = Web3Client(_rpcUrl, Client());
    _client = Impfy(address: _contractAddress, client: client);
  }

  // Future<Map<String, Certificate>> getCertificates() async {
  //   var privateKey = '';
  //   var passphrase = '';
  //   EthereumAddress address = await _credentials.extractAddress();
  //   var result = await _client.getCertificates(address);
  //   var x = { for (var e in result) e['certificateHash'] as String : decryptCertificate(e, privateKey, passphrase) };
  //   Map<String, Certificate> certificates = await Future.wait(x);
  //   return certificates;
  // }

  Future<void> createCertificate(
      Certificate certificate, EthereumAddress patient, String doctorKey, String patientKey) async {
    String hash = certificate.hashCode.toString();
    String signedHash = EthSigUtil.signTypedData(
        privateKey: _privateKey, jsonData: hash, version: TypedDataVersion.V4);
    String encryptedCertificate = await certificate.encrypt(doctorKey, patientKey);
    _client.addCertificate(encryptedCertificate, signedHash, patient, credentials: _credentials);
  }

  Future<Certificate> decryptCertificate(dynamic data, String privateKey, String passphrase) async {
    String certificateJson =
        await OpenPGP.decrypt(data['encryptedCertificate'], privateKey, passphrase);
    return Certificate.fromJson(jsonDecode(certificateJson));
  }
}
