import 'dart:convert';

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
}
