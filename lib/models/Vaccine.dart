// https://docs.flutter.dev/development/data-and-backend/json#manual-encoding
// abkürzungen kommen noch


class Vaccine {
  late String firstname;
  late String lastname;
  late DateTime vaccinationDate;
  late DateTime validUntil;
  late int dose;
  late String targetedDisease;
  late String vaccineType;
  late String product;
  late String manufacturer;
  late String countryOfVaccination;
  late String issuer;
  late String uvci;

  Vaccine(
      this.firstname,
      this.lastname,
      this.vaccinationDate,
      this.validUntil,
      this.dose,
      this.targetedDisease,
      this.vaccineType,
      this.product,
      this.manufacturer,
      this.countryOfVaccination,
      this.issuer,
      this.uvci
  );

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