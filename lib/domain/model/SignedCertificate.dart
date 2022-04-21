import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter_app/data/repository/Repository.dart';
import 'package:flutter_app/domain/model/Certificate.dart';

class SignedCertificate {
  final Certificate certificate;
  final String signedHash;

  SignedCertificate({required this.certificate, required this.signedHash});

  SignedCertificate.fromJson(Map<String, dynamic> json)
      : certificate = Certificate.fromJson(json['cert']),
        signedHash = json['hash'];

  Map<String, dynamic> toJson() => {'cert': certificate, 'hash': signedHash};

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  String _getHashCode() {
    return md5.convert(certificate.toString().codeUnits).toString();
  }

  Future<bool> verify() async {
    // Repository repository = Repository();
    // var unsignedHash = _getHashCode();
    // String address = EthSigUtil.ecRecover(
    //     signature: signedHash, message: Uint8List.fromList(unsignedHash.codeUnits));
    // BigInt blockNumber = await Repository().getDoctorValidityBlockNumber(address);
    // if (blockNumber == BigInt.zero) return false;
    // if (blockNumber == BigInt.one) return true;
    // return repository.certificateExistsAtBlock(signedHash, blockNumber - BigInt.one);
    return true;
  }
}
