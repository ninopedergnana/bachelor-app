import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/data/dto/UserAccountDTO.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../../domain/AuthProvider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  SignInState createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {
  late final AuthProvider _authProvider;

  @override
  void initState() {
    _authProvider = context.read<AuthProvider>();
    super.initState();
  }

  Future<String?> scanQR() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666',
          'Cancel',
          false, // show flash icon
          ScanMode.QR
          );
      return barcodeScanRes;
    } on PlatformException {
      return null;
    }
  }

  Future<void> scanUserKeys() async {
    String? value = await scanQR(); // Returns -1 when no QR was scanned.
    if (value != null && value != '-1') {
      UserAccountDTO user = UserAccountDTO.fromJson(jsonDecode(value));
      await _authProvider.signIn(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: scanUserKeys, child: const Text('Sign In'));
  }
}
