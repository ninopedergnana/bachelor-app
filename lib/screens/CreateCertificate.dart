import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Certificate.dart';
import 'package:intl/intl.dart' as intl;

class CreateCertificate extends StatelessWidget {
  const CreateCertificate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Create Certificate';

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: const CreateCertificateForm(),
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
  String? result;

  // JSON CONVERSION
  Certificate certificate = Certificate(
      product: '',
      uvci: '',
      manufacturer: '',
      targetedDisease: '',
      vaccineType: '',
      dose: 0,
      countryOfVaccination: '',
      issuer: '',
      validUntil: DateTime.now(),
      vaccinationDate: DateTime.now(),
      lastname: '',
      firstname: '');

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
                        (result == null)
                            ? TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/scan-patient')
                                      .then((value) => setState(() {
                                            result = value as String;
                                          }));
                                },
                                child: const Text('Scan Patient Key'),
                                style: TextButton.styleFrom(minimumSize: const Size.fromHeight(50)))
                            : Text(result!),
                        const SizedBox(height: 10),
                        TextInput(
                            label: 'First Name',
                            onChanged: (value) {
                              setState(() {
                                certificate.firstname = value;
                              });
                            }),
                        const SizedBox(height: 10),
                        TextInput(
                            label: 'Last Name',
                            onChanged: (value) {
                              setState(() {
                                certificate.lastname = value;
                              });
                            }),
                        const SizedBox(height: 10),
                        _FormDatePicker(
                          title: 'Vaccination Date',
                          date: certificate.vaccinationDate,
                          onChanged: (value) {
                            setState(() {
                              certificate.vaccinationDate = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        _FormDatePicker(
                          title: 'Valid Until',
                          date: certificate.validUntil,
                          onChanged: (value) {
                            setState(() {
                              certificate.validUntil = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          label: 'Dose',
                          onChanged: (value) {
                            setState(() {
                              certificate.dose = value as int;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          label: 'Targeted Disease',
                          onChanged: (value) {
                            setState(() {
                              certificate.targetedDisease = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          label: 'VaccineType',
                          onChanged: (value) {
                            setState(() {
                              certificate.vaccineType = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          label: 'Product',
                          onChanged: (value) {
                            setState(() {
                              certificate.product = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          label: 'Manufacturer',
                          onChanged: (value) {
                            setState(() {
                              certificate.manufacturer = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          label: 'Country Of Vaccination',
                          onChanged: (value) {
                            setState(() {
                              certificate.countryOfVaccination = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          label: 'Issuer',
                          onChanged: (value) {
                            setState(() {
                              certificate.issuer = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        TextInput(
                          label: 'UVCI',
                          onChanged: (value) {
                            setState(() {
                              certificate.uvci = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // return to home, doesnt work yet for some reason
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
                                        const SnackBar(
                                            content: Text('Vaccine Entered Successfully')),
                                      );
                                    }
                                    Navigator.pushNamed(context,
                                        '/'); // return to home, doesnt work yet for some reason
                                  },
                                  child: const Text('Submit'),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ))),
        ));
  }
}

class TextInput extends StatelessWidget {
  final String label;
  final void Function(String) onChanged;

  const TextInput({Key? key, required this.label, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty.';
          }
          return null;
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          filled: false,
          hintText: label,
          labelText: label,
        ),
        onChanged: onChanged);
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
