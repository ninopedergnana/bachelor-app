import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanCertificate extends StatefulWidget {
  const ScanCertificate({Key? key}) : super(key: key);

  @override
  ScanCertificateState createState() => ScanCertificateState();
}

class ScanCertificateState extends State<ScanCertificate> {
  String qrCodeString = 'Nothing scanned yet';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666',  // line color
          'Cancel',   // cancel button text
          false,      // show flash icon
          ScanMode.QR // scan mode
      );
      // handle the string function comes here
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      qrCodeString = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('QR Code Scanner'),
              centerTitle: true,
            ),
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
                            Text('Scan result : $qrCodeString\n',
                                style: const TextStyle(fontSize: 20))
                          ]));
                })));
  }
}