class Template {
  String? templateName; // only used for dropdown
  DateTime? vaccinationDate;
  DateTime? validUntil;
  int? dose;
  String? targetedDisease;
  String? vaccineType;
  String? product;
  String? manufacturer;
  String? countryOfVaccination;
  String? issuer;

  Template(
      {this.templateName,
      this.vaccinationDate,
      this.validUntil,
      this.dose,
      this.targetedDisease,
      this.vaccineType,
      this.product,
      this.manufacturer,
      this.countryOfVaccination,
      this.issuer});

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

  static List<Template> getDefaultTemplates() {
    return [
      Template(
        templateName: "Empty Template",
        vaccinationDate: DateTime.now(),
        validUntil: DateTime.now(),
        dose: 1,
        targetedDisease: "",
        vaccineType: "",
        product: "",
        manufacturer: "",
        countryOfVaccination: "",
        issuer: "",
      ),
      Template(
        templateName: "Moderna-Covid",
        vaccinationDate: DateTime.now(),
        validUntil: DateTime.now(),
        dose: 1,
        targetedDisease: "Covid",
        vaccineType: "mRNA",
        product: "Moderna Vaccine",
        manufacturer: "Moderna",
        countryOfVaccination: "CH",
        issuer: "BAG",
      ),
      Template(
        templateName: "Sputnik-Covid",
        vaccinationDate: DateTime.now(),
        validUntil: DateTime.now(),
        dose: 1,
        targetedDisease: "Covid",
        vaccineType: "mRNA",
        product: "Sputnik Vaccine",
        manufacturer: "Sputnik",
        countryOfVaccination: "CH",
        issuer: "BAG",
      ),
      Template(
        templateName: "Pfizer-Covid",
        vaccinationDate: DateTime.now(),
        validUntil: DateTime.now(),
        dose: 1,
        targetedDisease: "Covid",
        vaccineType: "mRNA",
        product: "Pfizer Vaccine",
        manufacturer: "Pfizer",
        countryOfVaccination: "CH",
        issuer: "BAG",
      )
    ];
  }
}
