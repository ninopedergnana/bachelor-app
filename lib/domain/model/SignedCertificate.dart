import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter_app/data/repository/repository.dart';
import 'package:flutter_app/domain/model/Certificate.dart';

class SignedCertificate {
  final Certificate certificate;
  final String signedHash;
  final String ipfsHash;

  SignedCertificate({required this.certificate, required this.signedHash, required this.ipfsHash});

  SignedCertificate.fromJson(Map<String, dynamic> json)
      : certificate = Certificate.fromJson(json['cert']),
        signedHash = json['hash'],
        ipfsHash = json['ipfs'];

  Map<String, dynamic> toJson() => {'cert': certificate, 'hash': signedHash, 'ipfs': ipfsHash};

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  String _getHashCode() {
    return md5.convert(certificate.toString().codeUnits).toString();
  }

  Future<bool> verify() async {
    Repository repository = Repository();
    var unsignedHash = _getHashCode();
    String signer = EthSigUtil.ecRecover(
        signature: signedHash, message: Uint8List.fromList(unsignedHash.codeUnits));
    if (await repository.isDoctor(signer)) {
      return await repository.isValidCertificate(signer, ipfsHash);
    } else {
      return false;
    }
  }
}
