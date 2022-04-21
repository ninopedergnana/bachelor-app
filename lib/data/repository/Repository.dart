import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_app/data/api/ipfs.dart';
import 'package:flutter_app/data/dto/PatientDTO.dart';
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
  late final Impfy _impfy;

  factory Repository() {
    return _instance;
  }

  Repository._internal() {
    String hexAddress = '0x926684114C466a2D6Ad87292fEC30E98aC8e0196';
    EthereumAddress contractAddress = EthereumAddress.fromHex(hexAddress);
    String rpcUrl = 'https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161';
    var client = Web3Client(rpcUrl, Client());
    _impfy = Impfy(address: contractAddress, client: client);
  }

  Future<List<SignedCertificate>> getCertificates() async {
    String passphrase = '';

    var response = (await _impfy.getCertificates());
    var certificates = response
        .map((element) => List.from(element))
        .map((element) => _decryptCertificate(element, passphrase));

    return (await Future.wait(certificates)).whereType<SignedCertificate>().toList();
  }

  Future<void> createCertificate(Certificate certificate, PatientDTO patient) async {
    String pgpDoctorPublicKey = (await _secureStore.read(key: 'pgpPublicKey'))!;
    String ethPrivateKey = (await _secureStore.read(key: 'ethPrivateKey'))!;
    Credentials credentials = EthPrivateKey.fromHex(ethPrivateKey);
    String hash = md5.convert(certificate.toString().codeUnits).toString();
    String signedHash = EthSigUtil.signMessage(
        privateKey: ethPrivateKey, message: Uint8List.fromList(hash.codeUnits));
    String encryptedCertificate =
        await certificate.encrypt(pgpDoctorPublicKey, patient.pgpPublicKey);
    String ipfsHash = await _ipfs.postCertificate(encryptedCertificate);
    _impfy.addCertificate(signedHash, ipfsHash, EthereumAddress.fromHex(patient.ethAddress),
        credentials: credentials);
  }

  Future<SignedCertificate?> _decryptCertificate(List<dynamic> data, String passphrase) async {
    String encryptedCertificate = data.first as String;
    String signedHash = data.last as String;
    String privateKey = (await _secureStore.read(key: 'pgpPrivateKey'))!;
    try {
      String certificateJson = await OpenPGP.decrypt(encryptedCertificate, privateKey, passphrase);
      Certificate certificate = Certificate.fromJson(json.decode(certificateJson));
      return SignedCertificate(certificate: certificate, signedHash: signedHash);
    } catch (e) {
      return null;
    }
  }

  Future<bool> isDoctor(String address) async {
    // TODO: Check if address belongs to doctor, once function is added to contract.
    // await _client.isDoctor(EthereumAddress.fromHex(address));
    return address.toLowerCase() == '0x08A6475d8F8668DD93fa3bd3AD87D83312a152d6'.toLowerCase();
  }
}
