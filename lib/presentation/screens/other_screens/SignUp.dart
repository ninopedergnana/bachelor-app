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
      body: const SignUpForm(),
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
  final FlutterSecureStorage _secureStore = const FlutterSecureStorage();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();

  Future<bool> generateKeys() async {
    EthPrivateKey credentials = EthPrivateKey.createRandom(Random.secure());

    var keyOptions = KeyOptions()..rsaBits = 512;
    var pgpKeyPair = await OpenPGP.generate(
        options: Options()
          ..name = '${firstName.text} ${lastName.text}'
          ..email = email.text
          ..passphrase = ''
          ..keyOptions = keyOptions);

    String ethPrivate = '0x' + credentials.privateKeyInt.toRadixString(16);

    return await storeKeys(pgpKeyPair.privateKey, pgpKeyPair.publicKey, ethPrivate);
  }

  Future<bool> storeKeys(pgpPrivate, pgpPublic, ethPrivate) async {
    Future.wait([
      _secureStore.write(key: 'pgpPrivateKey', value: pgpPrivate),
      _secureStore.write(key: 'pgpPublicKey', value: pgpPublic),
      _secureStore.write(key: 'ethPrivateKey', value: ethPrivate),
      _secureStore.write(key: 'firstName', value: firstName.text),
      _secureStore.write(key: 'lastName', value: lastName.text),
    ]);
    Map localStorageMap = await _secureStore.readAll();
    return localStorageMap.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your First Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      filled: false,
                      hintText: 'First Name',
                      labelText: 'First Name',
                    ),
                    controller: firstName,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
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
                    controller: lastName,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
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
                    controller: email,
                  ),
                  const SizedBox(height: 15.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() && await generateKeys()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Signup Successful!")),
                        );
                        Navigator.pushNamed(context, '/');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Key Generation Failed")),
                        );
                      }
                    },
                    child: const Text('Sign Up'),
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
