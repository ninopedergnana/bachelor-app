import 'dart:convert';
import 'dart:typed_data';

import 'package:quiver/iterables.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_app/data/api/ipfsApi.dart';
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
  final FlutterSecureStorage _secureStore = const FlutterSecureStorage();
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
    String privateKey = (await _secureStore.read(key: 'pgpPrivateKey'))!;

    // result structure currently unknown
    // var signedHashes = await _client.getCertificates();
    // var ipfsHashes = await _client.getIpfsHashes(signedHashes);
    var signedHashes = [];
    var ipfsHashes = [];
    var encryptedCertificates = await Future.wait(ipfsHashes.map((e) => getFromIPFS(e)));

    var certificates = zip([signedHashes, encryptedCertificates]).map((e) {
      return _decryptCertificate(e[1], e[0], privateKey, passphrase);
    });
    return (await Future.wait(certificates)).whereType<SignedCertificate>().toList();
  }

  Future<void> createCertificate(Certificate certificate, PatientKeysDTO patientKeys) async {
    String ethPrivateKey = (await _secureStore.read(key: 'ethPrivateKey'))!;
    Credentials credentials = EthPrivateKey.fromHex(ethPrivateKey);
    EthereumAddress patientAddress = EthereumAddress.fromHex(patientKeys.ethAddress);

    String signedHash = _getSignedHash(ethPrivateKey, certificate);
    String encryptedCertificate = await certificate.encrypt(patientKeys.pgpKey);

    String ipfsHash = await storeOnIPFS(encryptedCertificate);
    await _client.addCertificate(signedHash, ipfsHash, patientAddress, credentials: credentials);
  }

  String _getSignedHash(String privateKey, Certificate certificate) {
    String hash = md5.convert(certificate.toString().codeUnits).toString();
    Uint8List message = Uint8List.fromList(hash.codeUnits);
    return EthSigUtil.signMessage(privateKey: privateKey, message: message);
  }

  Future<SignedCertificate?> _decryptCertificate(
      encryptedCertificate, signedHash, String privateKey, String passphrase) async {
    try {
      String certificateJson = await OpenPGP.decrypt(encryptedCertificate, privateKey, passphrase);
      Certificate certificate = Certificate.fromJson(json.decode(certificateJson));
      return SignedCertificate(certificate: certificate, signedHash: signedHash);
    } catch (e) {
      return null;
    }
  }

  Future<BigInt> getDoctorValidityBlockNumber(String address) async {
    EthereumAddress doctorAddress = EthereumAddress.fromHex(address);
    // return await _client.getDoctorValidityBlockNumber(doctorAddress);
    return BigInt.one;
  }

  Future<bool> certificateExistsAtBlock(String signedHash, BigInt blockNumber) async {
    return false;
  }
}
