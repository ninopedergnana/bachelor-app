import 'package:flutter/material.dart';
import 'package:openpgp/openpgp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/Person.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Sign Up'),
          ),
          body: const SignUpForm(),
        ),
    );
  }
}

// Create a Form widget.
class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}


// Create a corresponding State class.
// This class holds data related to the form.
class SignUpFormState extends State<SignUpForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final FlutterSecureStorage _localStorage = const FlutterSecureStorage();

  Person person = Person(
    firstname: '',
    lastname: '',
    email: '',
    passphrase: ''
  );

  bool? keysGenerated;

  Map keyMap = <String, String>{};

  Future<bool> generatePGPKeys() async {
    var keyOptions = KeyOptions()..rsaBits = 1024;
    var keyPair1 = await OpenPGP.generate(
        options: Options()
          ..name = person.firstname + person.lastname
          ..email = person.email
          ..passphrase = person.passphrase
          ..keyOptions = keyOptions
    );

    keyMap['pgpPublicKey'] = keyPair1.publicKey;
    keyMap['pgpPrivateKey'] = keyPair1.privateKey;
    bool success = await savePGPKeys();

    return success;
  }

  Future<bool> savePGPKeys() async {
    await _localStorage.write(key: 'pgpPublicKey', value: keyMap['pgpPublicKey']);
    await _localStorage.write(key: 'pgpPrivateKey', value: keyMap['pgpPrivateKey']);
    Map localStorageMap = await _localStorage.readAll();
    return localStorageMap.isNotEmpty;
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      filled: false,
                      hintText: 'First Name',
                      labelText: 'First Name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        person.firstname = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your First Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      filled: false,
                      hintText: 'Last Name',
                      labelText: 'Last Name',
                    ),
                    onChanged: (value) {
                      setState(() {
                        person.lastname = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Email';
                      }

                      // // using regular expression
                      // if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      //     .hasMatch(value)) {
                      //   return "Please enter a valid email address";
                      // }

                      return null;
                    },
                    decoration: const InputDecoration(
                      filled: false,
                      hintText: 'Email',
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      setState(() {
                        person.email = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      filled: false,
                      hintText: 'Password',
                      labelText: 'Password',
                    ),
                    onChanged: (value) {
                      setState(() {
                        person.passphrase = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15.0),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() && await generatePGPKeys()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Keys Generated")),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Key Generation Failed")),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}