import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_app/data/dto/user_account_dto.dart';
import 'package:flutter_app/domain/model/signed_certificate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../data/dto/patient_dto.dart';

Future<String?> scanQR() async {
  try {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        false, // show flash icon
        ScanMode.QR);
    return barcodeScanRes;
  } on PlatformException {
    return null;
  }
}

/// For patient info when creating new certificate
Future<PatientDTO?> scanPatient() async {
  String? value = await scanQR(); // Returns -1 when no QR was scanned.
  if (value != null && value != '-1') {
    PatientDTO patient = PatientDTO.fromJson(jsonDecode(value));
    return patient;
  }
  return null;
}

/// For sign in
Future<UserAccountDTO?> scanUser() async {
  String? value = await scanQR(); // Returns -1 when no QR was scanned.
  if (value != null && value != '-1') {
    UserAccountDTO user = UserAccountDTO.fromJson(jsonDecode(value));
    return user;
  }
  return null;
}

Future<SignedCertificate?> scanCertificate() async {
  String? value = await scanQR(); // Returns -1 when no QR was scanned.
  if (value != null && value != '-1') {
    SignedCertificate certificate =
        SignedCertificate.fromJson(jsonDecode(value));
    return certificate;
  }
  return null;
}
