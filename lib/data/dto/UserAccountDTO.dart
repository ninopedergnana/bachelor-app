import 'dart:convert';

class UserAccountDTO {
  final String pgpPrivateKey;
  final String pgpPublicKey;
  final String ethPrivateKey;
  final String firstName;
  final String lastName;

  UserAccountDTO(
      {required this.pgpPrivateKey,
      required this.pgpPublicKey,
      required this.ethPrivateKey,
      required this.firstName,
      required this.lastName});

  UserAccountDTO.fromJson(Map<String, dynamic> json)
      : pgpPrivateKey = json['pPr'],
        pgpPublicKey = json['pPu'],
        ethPrivateKey = json['ePr'],
        firstName = json['fn'],
        lastName = json['ln'];

  Map<String, dynamic> toJson() => {
        'pPr': pgpPrivateKey,
        'pPu': pgpPublicKey,
        'ePr': ethPrivateKey,
        'fn': ethPrivateKey,
        'ln': ethPrivateKey,
      };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
