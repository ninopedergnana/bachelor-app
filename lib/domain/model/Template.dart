
import 'package:flutter/material.dart';

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

  Template({
    this.templateName,
    this.vaccinationDate,
    this.validUntil,
    this.dose,
    this.targetedDisease,
    this.vaccineType,
    this.product,
    this.manufacturer,
    this.countryOfVaccination,
    this.issuer
  });

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