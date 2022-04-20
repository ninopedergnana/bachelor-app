import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Template.dart';

class DropDownButtonWidget extends StatefulWidget {
  // used to pass the right template to the create vaccine widget
  final ValueChanged<Template> onValueChanged;

  const DropDownButtonWidget({Key? key, required this.onValueChanged}) : super(key: key);

  @override
  State<DropDownButtonWidget> createState() => DropDownButtonWidgetState();
}

class DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  Template? chosenTemplate; // will be filled with one from the list
  List<Template> templates = <Template>[
    Template(
      templateName: "Empty Template",
      vaccinationDate: DateTime.now(),
      validUntil: DateTime.now(),
      dose: 0,
      targetedDisease: "",
      vaccineType: "",
      product: "",
      manufacturer: "",
      countryOfVaccination: "",
      issuer: ""
    ),
    Template(
        templateName: "Moderna-Covid",
        vaccinationDate: DateTime.now(),
        validUntil: DateTime.now(),
        dose: 0,
        targetedDisease: "Covid",
        vaccineType: "mRNA",
        product: "Moderna Vaccine",
        manufacturer: "Moderna",
        countryOfVaccination: "CH",
        issuer: "BAG"
    ),
    Template(
        templateName: "Sputnik-Covid",
        vaccinationDate: DateTime.now(),
        validUntil: DateTime.now(),
        dose: 0,
        targetedDisease: "Covid",
        vaccineType: "mRNA",
        product: "Sputnik Vaccine",
        manufacturer: "Sputnik",
        countryOfVaccination: "CH",
        issuer: "BAG"
    ),
    Template(
        templateName: "Pfizer-Covid",
        vaccinationDate: DateTime.now(),
        validUntil: DateTime.now(),
        dose: 0,
        targetedDisease: "Covid",
        vaccineType: "mRNA",
        product: "Pfizer Vaccine",
        manufacturer: "Pfizer",
        countryOfVaccination: "CH",
        issuer: "BAG"
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DropdownButtonFormField<Template>(
        decoration: const InputDecoration(
          labelText: "Choose a Template"
        ),
        value: chosenTemplate == null ? null : templates[0],
        icon: const Icon(Icons.arrow_downward),
        isExpanded: true,
        elevation: 16,
        style: const TextStyle(color: Colors.blueGrey),
        onChanged: (Template? newTemplate) {
          setState(() {
            chosenTemplate = newTemplate!;
          });
          // passes chosen template to create widget. same style as datepicker
          widget.onValueChanged(chosenTemplate!);
        },
        items: templates.map((Template template) {
          return DropdownMenuItem<Template>(
            value: template,
            child: Text(template.templateName!),
          );
        }).toList(),
      ),
    );
  }
}
