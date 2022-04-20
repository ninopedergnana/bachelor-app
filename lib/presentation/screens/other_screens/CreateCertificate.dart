import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/PatientKeysDTO.dart';
import 'package:flutter_app/data/repository/Repository.dart';
import 'package:flutter_app/domain/model/Certificate.dart';
import 'package:flutter_app/presentation/components/DropDownButtonWidget.dart';
import 'dart:convert';
import '../../components/FormDatePicker.dart';
import '../../components/TextInput.dart';

class CreateCertificate extends StatelessWidget {
  const CreateCertificate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Create Certificate';

    return const Scaffold(
      body: CreateCertificateForm(),
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


  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  DateTime vaccDateController = DateTime.now();
  DateTime validUntilController = DateTime.now();
  TextEditingController doseController = TextEditingController();
  TextEditingController targetDisController = TextEditingController();
  TextEditingController vaccTypeController = TextEditingController();
  TextEditingController productController = TextEditingController();
  TextEditingController manufactController = TextEditingController();
  TextEditingController countryOfVaccController = TextEditingController();
  TextEditingController issuerController = TextEditingController();
  TextEditingController uvciController = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        elevation: 0,
      ),
      body: Form(
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
                      const DropDownButtonWidget(),
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
                        textEditingController: fnController,
                        label: 'First Name',
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        textEditingController: lnController,
                        label: 'Last Name',
                      ),
                      const SizedBox(height: 10),
                      FormDatePicker(
                        title: 'Vaccination Date',
                        date: vaccDateController,
                        onChanged: (value) {
                          setState(() {
                            vaccDateController = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      FormDatePicker(
                        title: 'Valid Until',
                        date: validUntilController,
                        onChanged: (value) {
                          setState(() {
                            validUntilController = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        textEditingController: doseController,
                        label: 'Dose',
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        textEditingController: targetDisController,
                        label: 'Targeted Disease',
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        textEditingController: vaccTypeController,
                        label: 'VaccineType',
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        textEditingController: productController,
                        label: 'Product',
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        textEditingController: manufactController,
                        label: 'Manufacturer',
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        textEditingController: countryOfVaccController,
                        label: 'Country Of Vaccination',
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        textEditingController: issuerController,
                        label: 'Issuer',
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        textEditingController: uvciController,
                        label: 'UVCI',
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() && _patientKeys == null) {
                                    Certificate certificate = Certificate()
                                      ..firstname = fnController.text
                                      ..lastname = lnController.text
                                      ..vaccinationDate = vaccDateController
                                      ..validUntil = validUntilController
                                      ..dose = int.parse(doseController.text)
                                      ..targetedDisease = targetDisController.text
                                      ..vaccineType = vaccTypeController.text
                                      ..product = productController.text
                                      ..manufacturer = manufactController.text
                                      ..countryOfVaccination = countryOfVaccController.text
                                      ..issuer = issuerController.text
                                      ..uvci = uvciController.text;

                                    print(certificate);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Vaccine Entered Successfully')),
                                    );
                                    //_repository.createCertificate(certificate, _patientKeys!);
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
          )),
    );
  }
}



