import 'dart:convert';

class CertificateDTO {
  final String encryptedCertificate;
  final String signedHash;

  CertificateDTO({
    required this.encryptedCertificate,
    required this.signedHash,
  });

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
