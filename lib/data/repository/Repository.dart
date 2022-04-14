import 'dart:convert';

import 'package:flutter_app/data/dto/PatientKeysDTO.dart';
import 'package:flutter_app/domain/model/Certificate.dart';
import 'package:flutter_app/impfy.g.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openpgp/openpgp.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

// TODO: Convert to singleton
class Repository {
  final FlutterSecureStorage _localStorage = const FlutterSecureStorage();
  late Impfy _client;
  final EthereumAddress _contractAddress =
      EthereumAddress.fromHex('0xb58d3d11966CCeB725e39C3d6D0d383Bf3F1cec3');
  final String _rpcUrl =
      'https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161';

  Repository() {
    var client = Web3Client(_rpcUrl, Client());
    _client = Impfy(address: _contractAddress, client: client);
  }

  Future<List<Certificate>> getCertificates() async {
    String passphrase = '';

    // ethereum privat key fetched, and public key generated with credentials
    String ethPrivateKey = (await _localStorage.read(key: 'ethPrivateKey'))!;
    Credentials credentials = EthPrivateKey.fromHex(ethPrivateKey);
    EthereumAddress address = await credentials.extractAddress();

    // result structure currently unknown
    var result = (await _client.getCertificates(address));
    var certs = result.map((element) {
      return List.from(element);
    });

    var x = certs.map((e) => e.first).map((e) => decryptCertificate(e, passphrase));

    return Future.wait(List.from(x));
  }

  Future<void> createCertificate(
      Certificate certificate, PatientKeysDTO patientKeys) async {
    String pgpDoctorPublicKey =
        (await _localStorage.read(key: 'pgpPublicKey'))!;
    String ethPrivateKey = (await _localStorage.read(key: 'ethPrivateKey'))!;
    Credentials credentials = EthPrivateKey.fromHex(ethPrivateKey);
    String hash = certificate.hashCode.toString();
    // String signedHash = EthSigUtil.signTypedData(
    //     privateKey: privateKey, jsonData: json.encode({"hash": hash}), version: TypedDataVersion.V4);
    String encryptedCertificate =
        await certificate.encrypt(pgpDoctorPublicKey, patientKeys.pgpKey);
    _client.addCertificate(encryptedCertificate, hash,
        EthereumAddress.fromHex(patientKeys.ethAddress),
        credentials: credentials);
  }

  Future<Certificate> decryptCertificate(String data, String passphrase) async {
    String privateKey = (await _localStorage.read(key: 'pgpPrivateKey'))!;
    String certificateJson = await OpenPGP.decrypt(
        data, privateKey, passphrase);
    return Certificate.fromJson(jsonDecode(certificateJson));
  }
}
