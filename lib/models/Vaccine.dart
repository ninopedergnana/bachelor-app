// https://docs.flutter.dev/development/data-and-backend/json#manual-encoding
// abkürzungen kommen noch


class Vaccine {
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

  Vaccine({
    required this.firstname,
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
    required this.uvci
  });

  Vaccine.fromJson(Map<String, dynamic> json)
      : firstname = json['firstname'],
        lastname = json['lastname'],
        vaccinationDate = json['vaccinationDate'],
        validUntil = json['validUntil'],
        dose = json['dose'],
        targetedDisease = json['targetedDisease'],
        vaccineType = json['vaccineType'],
        product = json['product'],
        manufacturer = json['manufacturer'],
        countryOfVaccination = json['countryOfVaccination'],
        issuer = json['issuer'],
        uvci = json['uvci'];

  Map<String, dynamic> toJson() => {
    'firstname': firstname,
    'lastname': lastname,
    'vaccinationDate': vaccinationDate,
    'dose': dose,
    'targetedDisease': targetedDisease,
    'vaccineType': vaccineType,
    'product': product,
    'manufacturer': manufacturer,
    'countryOfVaccination': countryOfVaccination,
    'issuer': issuer,
    'uvci': uvci,
  };

}