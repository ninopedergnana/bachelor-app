import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openpgp/openpgp.dart';
import 'dart:convert';

// https://docs.flutter.dev/development/data-and-backend/json#manual-encoding

class Certificate {
  final FlutterSecureStorage _secureStore = const FlutterSecureStorage();
  String firstname;
  String lastname;
  DateTime vaccinationDate;
  DateTime validUntil;
  int dose;
  String targetedDisease;
  String vaccineType;
  String product;
  String manufacturer;
  String countryOfVaccination;
  String issuer;
  String uvci;

  Certificate(
      {required this.firstname,
      required this.lastname,
      required this.vaccinationDate,
      required this.validUntil,
      required this.dose,
      required this.targetedDisease,
      required this.vaccineType,
      required this.product,
      required this.manufacturer,
      required this.countryOfVaccination,
      required this.issuer,
      required this.uvci});

  Certificate.fromJson(Map<String, dynamic> json)
      : firstname = json['fn'],
        lastname = json['ln'],
        vaccinationDate = DateTime.parse(json['dt']),
        validUntil = DateTime.parse(json['vu']),
        dose = json['dn'],
        targetedDisease = json['tg'],
        vaccineType = json['vp'],
        product = json['mp'],
        manufacturer = json['ma'],
        countryOfVaccination = json['co'],
        issuer = json['is'],
        uvci = json['ci'];

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

  Future<String> encrypt(String patientKey) async {
    String? doctorKey = await _secureStore.read(key: 'pgpPublicKey');
    return await OpenPGP.encrypt(toString(), doctorKey! + patientKey);
  }
}
