import 'dart:convert';

class PatientDTO {
  final String pgpPublicKey;
  final String ethAddress;
  final String firstName;
  final String lastName;

  PatientDTO(
      {required this.pgpPublicKey,
      required this.ethAddress,
      required this.firstName,
      required this.lastName});

  PatientDTO.fromJson(Map<String, dynamic> json)
      : pgpPublicKey = json['pgp'],
        ethAddress = json['eth'],
        firstName = json['fn'],
        lastName = json['ln'];

  Map<String, dynamic> toJson() => {
        'pgp': pgpPublicKey,
        'eth': ethAddress,
        'fn': firstName,
        'ln': lastName,
      };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
