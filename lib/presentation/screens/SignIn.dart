import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/UserKeysDTO.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Sign In';

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: const SignInForm(),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final FlutterSecureStorage _localStorage = const FlutterSecureStorage();
  UserKeysDTO? _userKeys;

  Future<void> scanUserKeys() async {
    String value = await Navigator.pushNamed(context, '/scan-patient') as String;
    setState(() {
      if (value != '-1') {
        // Returns -1 when no QR was scanned.
        _userKeys = UserKeysDTO.fromJson(json.decode(value));
      }
    });
    await Future.wait([
    _localStorage.write(key: 'pgpPrivateKey', value: _userKeys!.pgpPrivateKey),
    _localStorage.write(key: 'pgpPublicKey', value: _userKeys!.pgpPublicKey),
    _localStorage.write(key: 'ethPrivateKey', value: _userKeys!.ethPrivateKey),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                scanUserKeys();
              },
              child: const Text('Scan User Keys')
          ),
        ],
      ),
    );
  }



}






