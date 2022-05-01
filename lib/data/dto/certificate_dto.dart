import 'dart:convert';

import 'package:flutter_app/domain/model/Certificate.dart';
import 'package:flutter_app/domain/model/SignedCertificate.dart';

class CertificateDTO {
  final String encryptedCertificate;
  final String signedHash;

  CertificateDTO({required this.encryptedCertificate, required this.signedHash});

  CertificateDTO.fromJson(Map<String, dynamic> json)
      : encryptedCertificate = json['encryptedCertificate'],
        signedHash = json['signedHash'];

  Map<String, dynamic> toJson() => {
        'encryptedCertificate': encryptedCertificate,
        'signedHash': signedHash,
      };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
