import 'package:flutter_app/domain/model/Template.dart';
import 'package:openpgp/openpgp.dart';
import 'dart:convert';

class Certificate extends Template {
  String? firstname;
  String? lastname;
  String? uvci;

  Certificate();

  Certificate.fromTemplate(
      Template template,
      {
      this.firstname,
      this.lastname,
      this.uvci
      }
  ): super.isNamedConstructor(template);

  Certificate.fromJson(Map<String, dynamic> json) {
    firstname = json['fn'];
    lastname = json['ln'];
    vaccinationDate = DateTime.parse(json['dt']);
    validUntil = DateTime.parse(json['vu']);
    dose = json['dn'];
    targetedDisease = json['tg'];
    vaccineType = json['vp'];
    product = json['mp'];
    manufacturer = json['ma'];
    countryOfVaccination = json['co'];
    issuer = json['is'];
    uvci = json['ci'];
  }

  Map<String, dynamic> toJson() => {
        'fn': firstname,
        'ln': lastname,
        'dt': vaccinationDate.toString(),
        'vu': validUntil.toString(),
        'dn': dose,
        'tg': targetedDisease,
        'vp': vaccineType,
        'mp': product,
        'ma': manufacturer,
        'co': countryOfVaccination,
        'is': issuer,
        'ci': uvci,
      };

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  Future<String> encrypt(String doctorKey, String patientKey) async {
    return await OpenPGP.encrypt(toString(), doctorKey + patientKey);
  }
}
