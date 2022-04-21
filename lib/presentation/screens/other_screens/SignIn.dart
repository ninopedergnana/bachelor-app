import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/UserAccountDTO.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignInForm(),
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

  Future<void> scanUserKeys() async {
    const FlutterSecureStorage secureStore = FlutterSecureStorage();
    String value = await Navigator.pushNamed(context, '/scan-patient') as String;
    // Returns -1 when no QR was scanned.
    if (value != '-1') {
      UserAccountDTO user = UserAccountDTO.fromJson(json.decode(value));
      await Future.wait([
        secureStore.write(key: 'pgpPrivateKey', value: user.pgpPrivateKey),
        secureStore.write(key: 'pgpPublicKey', value: user.pgpPublicKey),
        secureStore.write(key: 'ethPrivateKey', value: user.ethPrivateKey),
        secureStore.write(key: 'firstName', value: user.firstName),
        secureStore.write(key: 'lastName', value: user.lastName),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ElevatedButton(onPressed: scanUserKeys, child: const Text('Scan User Keys')),
        ),
      ),
    );
  }
}
