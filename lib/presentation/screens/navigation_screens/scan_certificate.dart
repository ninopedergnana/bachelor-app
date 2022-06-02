import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/domain/model/signed_certificate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../components/large_button.dart';
import '../../navigation/routes.gr.dart';

class ScanCertificate extends StatefulWidget {
  const ScanCertificate({Key? key}) : super(key: key);

  @override
  ScanCertificateState createState() => ScanCertificateState();
}

class ScanCertificateState extends State<ScanCertificate> {
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
        ScanMode.QR,
      );
      setState(() {
        try {
          SignedCertificate signedCertificate =
              SignedCertificate.fromJson(jsonDecode(barcodeScanRes));
          AutoRouter.of(context).push(CertificateDetailRoute(
            signedCertificate: signedCertificate,
            isVerification: true,
          ));
        } catch (e) {}
      });
    } on PlatformException {
      // barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        minimumSize: Size.infinite,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      onPressed: scanQR,
      child: const Text(
        'Scan Certificate',
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
