import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/signed_certificate.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../components/detail_view_custom_text.dart';

class CertificateDetail extends StatelessWidget {
  final SignedCertificate signedCertificate;
  final bool isVerification;

  const CertificateDetail({
    Key? key,
    required this.signedCertificate,
    required this.isVerification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var certificate = signedCertificate.certificate;
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    final String validDate = formatter.format(certificate.validUntil!);
    final String vaccDate = formatter.format(certificate.vaccinationDate!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Header(
              signedCertificate: signedCertificate,
              isVerification: isVerification,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  DetailViewCustomText(
                      title: "Name",
                      content:
                          certificate.firstname! + " " + certificate.lastname!),
                  DetailViewCustomText(
                      title: "Vaccination Date", content: vaccDate),
                  DetailViewCustomText(
                      title: "Valid Until", content: validDate),
                  DetailViewCustomText(
                      title: "Dose", content: certificate.dose.toString()),
                  DetailViewCustomText(
                      title: "Targeted Disease",
                      content: certificate.targetedDisease),
                  DetailViewCustomText(
                      title: "Vaccine Type", content: certificate.vaccineType),
                  DetailViewCustomText(
                      title: "Product", content: certificate.product),
                  DetailViewCustomText(
                      title: "Issuer", content: certificate.issuer),
                  DetailViewCustomText(
                      title: "UVCI", content: certificate.uvci),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final SignedCertificate signedCertificate;
  final bool isVerification;

  const _Header({
    Key? key,
    required this.signedCertificate,
    required this.isVerification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isVerification) {
      return FutureBuilder(
        future: signedCertificate.verify(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(
              color:
                  snapshot.data ? Colors.green.shade600 : Colors.red.shade600,
              height: 50,
              width: double.infinity,
              child: Center(
                child: Text(
                  snapshot.data
                      ? 'Certificate is valid'
                      : 'Certificate is not valid',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          }
        },
      );
    } else {
      return Hero(
        tag: signedCertificate.signedHash,
        child: signedCertificate.getQR(),
      );
    }
  }
}
