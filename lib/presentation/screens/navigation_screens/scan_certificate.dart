import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/domain/model/signed_certificate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanCertificate extends StatefulWidget {
  const ScanCertificate({Key? key}) : super(key: key);

  @override
  ScanCertificateState createState() => ScanCertificateState();
}

class ScanCertificateState extends State<ScanCertificate> {
  SignedCertificate? _signedCertificate;
  bool? _isValid;

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666',
          'Cancel',
          false,
          ScanMode.QR
      );
      setState(() {
        try {
          _signedCertificate = SignedCertificate.fromJson(jsonDecode(barcodeScanRes));
          _signedCertificate!.verify().then((b) => _isValid = b);
        } catch(e) {
          _isValid = false;
        }
      });
    } on PlatformException {
      // barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    // if (_signedCertificate == null) scanQR();
    return Scaffold(
    backgroundColor: (_isValid != null && _isValid!) ? Colors.lightGreen : Colors.red,
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => scanQR(),
                  child: const Text('Scan QR')),
                Text('Scan result : ${_signedCertificate?.signedHash}\n',
                  style: const TextStyle(fontSize: 20)),
                Text('Is valid : $_isValid',
                  style: const TextStyle(fontSize: 20))
          ])
        );
      })
    );
  }
}