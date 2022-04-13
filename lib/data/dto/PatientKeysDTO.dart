import 'dart:convert';

class PatientKeysDTO {
  final String pgpKey;
  final String ethAddress;

  PatientKeysDTO({required this.pgpKey, required this.ethAddress});

  PatientKeysDTO.fromJson(Map<String, dynamic> json)
      : pgpKey = json['pgp'],
        ethAddress = json['eth'];

  Map<String, dynamic> toJson() => {
        'pgp': pgpKey,
        'eth': ethAddress,
      };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
