import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/patient_dto.dart';
import 'package:flutter_app/data/repository/repository.dart';
import 'package:flutter_app/domain/model/certificate.dart';
import 'package:flutter_app/presentation/components/drop_down_button_widget.dart';

import '../../components/form_date_picker.dart';
import '../../components/qr_scan.dart';
import '../../components/text_input.dart';

class CreateCertificate extends StatelessWidget {
  const CreateCertificate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  PatientDTO? _patientKeys;
  DropDownButtonWidgetState staty = DropDownButtonWidgetState();

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

  void fillFormValues(value) {
    vaccDateController = value.vaccinationDate ?? DateTime.now();
    validUntilController = value.validUntil ?? DateTime.now();
    doseController.text = value.dose.toString();
    targetDisController.text = value.targetedDisease!;
    vaccTypeController.text = value.vaccineType!;
    productController.text = value.product!;
    manufactController.text = value.manufacturer!;
    countryOfVaccController.text = value.countryOfVaccination!;
    issuerController.text = value.issuer!;
  }

  Future<void> scanPatientKey() async {
    _patientKeys = await scanPatient();
    setState(() {
      fnController.text = _patientKeys!.firstName;
      lnController.text = _patientKeys!.lastName;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        iconTheme: const IconThemeData(color: Color(0xff475c6c)),
        elevation: 0,
      ),
      body: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 400, minHeight: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed:
                              (_patientKeys == null) ? scanPatientKey : null,
                          child: Text(
                            (_patientKeys == null)
                                ? 'Scan Patient Key'
                                : 'Patient Key Scanned',
                            style: const TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                              minimumSize: const Size.fromHeight(60),
                              backgroundColor: (_patientKeys == null)
                                  ? Colors.green.shade400
                                  : Colors.grey)),
                      const SizedBox(height: 10),
                      DropDownButtonWidget(
                        onValueChanged: (value) {
                          fillFormValues(value);
                        },
                      ),
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
                                  if (_formKey.currentState!.validate() &&
                                      _patientKeys != null) {
                                    Certificate certificate = Certificate()
                                      ..firstname = fnController.text
                                      ..lastname = lnController.text
                                      ..vaccinationDate = vaccDateController
                                      ..validUntil = validUntilController
                                      ..dose = int.parse(doseController.text)
                                      ..targetedDisease =
                                          targetDisController.text
                                      ..vaccineType = vaccTypeController.text
                                      ..product = productController.text
                                      ..manufacturer = manufactController.text
                                      ..countryOfVaccination =
                                          countryOfVaccController.text
                                      ..issuer = issuerController.text
                                      ..uvci = uvciController.text;

                                    _repository.createCertificate(
                                        certificate, _patientKeys!);

                                    // close keyboard after submission
                                    FocusManager.instance.primaryFocus?.unfocus();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Vaccine Entered Successfully')),
                                    );
                                    //_repository.createCertificate(certificate, _patientKeys!);
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Submit'),
                                style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff475c6c),
                                    elevation: 0.0,
                                    minimumSize: const Size(120, 60)),
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
