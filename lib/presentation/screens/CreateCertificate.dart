import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/PatientKeysDTO.dart';
import 'package:flutter_app/data/repository/Repository.dart';
import 'package:flutter_app/domain/model/Certificate.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:convert';

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

class CreateCertificateFormState extends State<CreateCertificateForm> {
  final _formKey = GlobalKey<FormState>();
  final Repository _repository = Repository();
  PatientKeysDTO? _patientKeys;

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

  Future<void> scanPatientKey() async {
    String value = await Navigator.pushNamed(context, '/create-certificate/scan-patient') as String;
    setState(() {
      if (value != '-1') {
        // Returns -1 when no QR was scanned.
        _patientKeys = PatientKeysDTO.fromJson(json.decode(value));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400, minHeight: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: (_patientKeys == null) ? scanPatientKey : null,
                        child: Text(
                          (_patientKeys == null) ? 'Scan Patient Key' : 'Patient Key Scanned',
                          style: const TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: (_patientKeys == null) ? Colors.blue : Colors.grey)),
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
                          certificate.dose = value as int; // throws error
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
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() && _patientKeys != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Vaccine Entered Successfully')),
                                  );
                                  _repository.createCertificate(certificate, _patientKeys!);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Submit'),
                              style: ElevatedButton.styleFrom(minimumSize: const Size(120, 60)),
                            ),
                          ],
                        )),
                  ],
                ),
              )),
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
