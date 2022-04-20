import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Template.dart';

class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget({Key? key}) : super(key: key);

  @override
  State<DropDownButtonWidget> createState() => DropDownButtonWidgetState();
}

class DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  DateTime today = DateTime.now();
  String dropdownValue = "Moderna";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: [
        Template(
            vaccinationDate: today,
            validUntil: DateTime(today.year, today.month + 6, today.day),
            dose: 0,
            targetedDisease: "Covid",
            vaccineType: "mRNA",
            product: "Moderna Vaccine",
            manufacturer: "Moderna",
            countryOfVaccination: "CH",
            issuer: "BAG"
        ),
        Template(
            vaccinationDate: today,
            validUntil: DateTime(today.year, today.month + 6, today.day),
            dose: 0,
            targetedDisease: "Covid",
            vaccineType: "mRNA",
            product: "Sputnik Vaccine",
            manufacturer: "Sputnik",
            countryOfVaccination: "CH",
            issuer: "BAG"
        ),
        Template(
            vaccinationDate: today,
            validUntil: DateTime(today.year, today.month + 6, today.day),
            dose: 0,
            targetedDisease: "Covid",
            vaccineType: "mRNA",
            product: "Pfizer Vaccine",
            manufacturer: "Pfizer",
            countryOfVaccination: "CH",
            issuer: "BAG"
        )
      ]
          .map<DropdownMenuItem<String>>((template) {
        return DropdownMenuItem<String>(
          value: template.manufacturer,
          child: Text(template.manufacturer!),
        );
      }).toList(),
    );
  }
}
