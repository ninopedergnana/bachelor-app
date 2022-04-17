import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanPatient extends StatefulWidget {
  const ScanPatient({Key? key}) : super(key: key);

  @override
  _ScanPatientState createState() => _ScanPatientState();
}

class _ScanPatientState extends State<ScanPatient> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', // line color
            'Cancel', // cancel button text
            false, // show flash icon
            ScanMode.QR // scan mode
            );
        Navigator.pop(context, barcodeScanRes);
    } on PlatformException {
      Navigator.pop(context);
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    scanQR();
    return const Scaffold();
  }
}
