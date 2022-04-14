import 'dart:convert';

class UserKeysDTO {
  final String pgpPrivateKey;
  final String pgpPublicKey;
  final String ethPrivateKey;

  UserKeysDTO({required this.pgpPrivateKey, required this.pgpPublicKey, required this.ethPrivateKey});

  UserKeysDTO.fromJson(Map<String, dynamic> json)
      : pgpPrivateKey = json['1'],
        pgpPublicKey = json['2'],
        ethPrivateKey = json['3'];

  Map<String, dynamic> toJson() => {
    '1': pgpPrivateKey,
    '2': pgpPublicKey,
    '3': ethPrivateKey,
  };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
