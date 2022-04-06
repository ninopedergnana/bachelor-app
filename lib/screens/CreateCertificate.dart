import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_app/models/Vaccine.dart';


class CreateCertificate extends StatelessWidget {
  const CreateCertificate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Create Certificate';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const CreateCertificateForm(),
      ),
    );
  }
}

// Create a Form widget.
class CreateCertificateForm extends StatefulWidget {
  const CreateCertificateForm({Key? key}) : super(key: key);

  @override
  CreateCertificateFormState createState() {
    return CreateCertificateFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class CreateCertificateFormState extends State<CreateCertificateForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  // JSON CONVERSION
  Vaccine vaccine = Vaccine("", "", DateTime.now(), DateTime.now(), 0, "", "", "", "", "", "", "");
  // Map<String,dynamic> map = vaccine.toJson();
  // String vaccineJSON = jsonEncode(map);


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Align(
        alignment: Alignment.topCenter,
        child: Card(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400, minHeight: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'First Name',
                      labelText: 'First Name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        vaccine.firstname = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Last Name',
                      labelText: 'Last Name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        vaccine.lastname = value;
                      });
                    },
                  ),
                  _FormDatePicker(
                    title: 'Vaccination Date',
                    date: vaccine.vaccinationDate,
                    onChanged: (value) {
                      setState(() {
                        vaccine.vaccinationDate = value;
                      });
                    },
                  ),
                  _FormDatePicker(
                    title: 'Valid Until',
                    date: vaccine.validUntil,
                    onChanged: (value) {
                      setState(() {
                        vaccine.validUntil = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Dose',
                      labelText: 'Dose',
                    ),
                    onChanged: (value) {
                      setState(() {
                        vaccine.dose = value as int;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Targeted Disease',
                      labelText: 'Targeted Disease',
                    ),
                    onChanged: (value) {
                      setState(() {
                        vaccine.targetedDisease = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'VaccineType',
                      labelText: 'VaccineType',
                    ),
                    onChanged: (value) {
                      setState(() {
                        vaccine.vaccineType = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Product',
                      labelText: 'Product',
                    ),
                    onChanged: (value) {
                      setState(() {
                        vaccine.product = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Manufacturer',
                      labelText: 'Manufacturer',
                    ),
                    onChanged: (value) {
                      setState(() {
                        vaccine.manufacturer = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Country Of Vaccination',
                      labelText: 'Country Of Vaccination',
                    ),
                    onChanged: (value) {
                      setState(() {
                        vaccine.countryOfVaccination = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Issuer',
                      labelText: 'Issuer',
                    ),
                    onChanged: (value) {
                      setState(() {
                        vaccine.issuer = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'UVCI',
                      labelText: 'UVCI',
                    ),
                    onChanged: (value) {
                      setState(() {
                        vaccine.uvci = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/'); // return to home, doesnt work yet for some reason
                          },
                          child: const Text('Back'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Vaccine Entered Successfully')),
                              );
                            }
                            Navigator.pushNamed(context, '/'); // return to home, doesnt work yet for some reason
                          },
                            child: const Text('Submit'),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            )
          )
        ),
      )
    );
  }
}

class _FormDatePicker extends StatefulWidget {
  final String title;
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    required this.title,
    required this.date,
    required this.onChanged,
  });

  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              intl.DateFormat.yMMMMd().format(widget.date),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        TextButton(
          child: const Text('Change'),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}