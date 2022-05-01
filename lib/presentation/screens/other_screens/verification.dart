import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/data/dto/user_account_dto.dart';
import 'package:flutter_app/domain/model/SignedCertificate.dart';
import 'package:flutter_app/presentation/components/large_button.dart';
import 'package:flutter_app/presentation/navigation/routes.gr.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../../../domain/auth_provider.dart';
import '../../components/qr_scan.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  VerificationState createState() {
    return VerificationState();
  }
}

class VerificationState extends State<Verification> {

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanCertificateQR() async {
    SignedCertificate? certificate = await scanCertificate();
    AutoRouter.of(context).push(const CertificateDetailRoute());
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return LargeButton(
      onPressed: scanCertificateQR,
      text: 'Verify',
    );
  }
}
