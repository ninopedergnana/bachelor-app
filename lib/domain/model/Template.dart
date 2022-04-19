
class Template {
  DateTime? vaccinationDate;
  DateTime? validUntil;
  int? dose;
  String? targetedDisease;
  String? vaccineType;
  String? product;
  String? manufacturer;
  String? countryOfVaccination;
  String? issuer;

  Template();

  Template.isNamedConstructor(Template template) {
    vaccinationDate = template.vaccinationDate;
    validUntil = template.validUntil;
    dose = template.dose;
    targetedDisease = template.targetedDisease;
    vaccineType = template.vaccineType;
    product = template.product;
    manufacturer = template.manufacturer;
    countryOfVaccination = template.countryOfVaccination;
    issuer = template.issuer;
  }
}