import 'dart:convert';

import 'package:flutter_app/data/dto/PatientKeysDTO.dart';
import 'package:flutter_app/domain/model/Certificate.dart';
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

 // Future<Map<String, Certificate>> getCertificates() async {
 //   var passphrase = '';
 //   String privateKey = (await _localStorage.read(key: 'ethPrivateKey'))!;
 //   Credentials credentials = EthPrivateKey.fromHex(privateKey);
 //   EthereumAddress address = await credentials.extractAddress();
 //   var result = await _client.getCertificates(address);
 //   var x = { for (var e in result) e['certificateHash'] as String : decryptCertificate(e, privateKey, passphrase) };
 //   Map<String, Certificate> certificates = await Future.wait(x);
 //   return certificates;
 // }

  Future<void> createCertificate(Certificate certificate, PatientKeysDTO patientKeys) async {
    String doctorKey = (await _localStorage.read(key: 'pgpPublicKey'))!;
    String privateKey = (await _localStorage.read(key: 'ethPrivateKey'))!;
    Credentials credentials = EthPrivateKey.fromHex(privateKey);
    String hash = certificate.hashCode.toString();
    // String signedHash = EthSigUtil.signTypedData(
    //     privateKey: privateKey, jsonData: json.encode({"hash": hash}), version: TypedDataVersion.V4);
    String encryptedCertificate = await certificate.encrypt(doctorKey, patientKeys.pgpKey);
    _client.addCertificate(
        encryptedCertificate, hash, EthereumAddress.fromHex(patientKeys.ethAddress),
        credentials: credentials);
  }

  Future<Certificate> decryptCertificate(dynamic data, String privateKey, String passphrase) async {
    String certificateJson =
        await OpenPGP.decrypt(data['encryptedCertificate'], privateKey, passphrase);
    return Certificate.fromJson(jsonDecode(certificateJson));
  }
}
