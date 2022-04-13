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
      String pgp = '''-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: openpgp-mobile

xjMEYla6LBYJKwYBBAHaRw8BAQdAgfUbjl+BbqXfGq17p2S6VYP7F7iTAR2y
qTv+O6Sty7/NKUNhcmxvcyBPbGdpYXRpIDxjYXJsb3NvbGdpYXRpQHBhdGll
bnQuY2g+wowEEBYKAB0FAmJWuiwECwkHCAMVCAoEFgACAQIZAQIbAwIeAQAh
CRCv1Ym6lMTGHhYhBLiCF3OCv3hGDX1uBq/VibqUxMYe3qEA/3moe437qbj8
tGTaiSJ1Nt4owlvxgIgFPqA9QcCmIYwpAQD1YCrZeyD6dJK7kw/0ttfN8voA
iXAU6zp2oa6Weu2PCs44BGJWuiwSCisGAQQBl1UBBQEBB0BgPtz+kWiYnwDH
A48HmwbTDUuA829VCR9fJOCGmMYaEgMBCAfCeAQYFggACQUCYla6LAIbDAAh
CRCv1Ym6lMTGHhYhBLiCF3OCv3hGDX1uBq/VibqUxMYeb5cBAM8dqxmKqXjJ
yVAhTUikci4hN3akxEUjzAWdtxO2UcR5AQDLbDpNmPVZQxB+Zb44a0uOa0A1
yCX7Vat9QI8XPcXLBA==
=jeXH
-----END PGP PUBLIC KEY BLOCK-----''';
      String eth = "0x5A65789deEDB2213C1d33b60C4Ba96D677d7ae92";
      Navigator.pop(context,  json.encode({"pgp": pgp, "eth": eth}));
      //   barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      //       '#ff6666', // line color
      //       'Cancel', // cancel button text
      //       false, // show flash icon
      //       ScanMode.QR // scan mode
      //       );
      //   Navigator.pop(context, barcodeScanRes);
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
