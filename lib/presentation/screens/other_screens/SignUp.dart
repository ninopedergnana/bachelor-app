import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Person.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openpgp/openpgp.dart';
import 'package:web3dart/credentials.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        elevation: 0,
      ),
      body: SignUpForm(),
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

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final FlutterSecureStorage _localStorage = const FlutterSecureStorage();
  Person person = Person(firstname: '', lastname: '', email: '', passphrase: '');
  bool? keysGenerated;
  Map keyMap = <String, String>{};

  Future<bool> generateKeys() async {
    EthPrivateKey credentials = EthPrivateKey.createRandom(Random.secure());
    var keyOptions = KeyOptions()..rsaBits = 1024;
    var keyPair1 = await OpenPGP.generate(
        options: Options()
          ..name = person.firstname + person.lastname
          ..email = person.email
          ..passphrase = ''
          ..keyOptions = keyOptions);
    keyMap['pgpPublicKey'] = keyPair1.publicKey;
    keyMap['pgpPrivateKey'] = keyPair1.privateKey;
    keyMap['ethPrivateKey'] = '0x' + credentials.privateKeyInt.toRadixString(16);

    bool success = await storeKeys();

    return success;
  }

  Future<bool> storeKeys() async {
    Future.wait([
      _localStorage.write(key: 'pgpPublicKey', value: keyMap['pgpPublicKey']),
      _localStorage.write(key: 'pgpPrivateKey', value: keyMap['pgpPrivateKey']),
      _localStorage.write(key: 'ethPrivateKey', value: keyMap['ethPrivateKey'])
    ]);
    Map localStorageMap = await _localStorage.readAll();
    return localStorageMap.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Form(
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
                      if (_formKey.currentState!.validate() && await generateKeys()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Keys Generated")),
                        );
                        Navigator.pushNamed(context, '/certificate-list');
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
      ),
    );
  }
}
