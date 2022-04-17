import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/SignedCertificate.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../components/DetailViewCustomText.dart';

class CertificateDetail extends StatelessWidget {
  const CertificateDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signedCertificate = ModalRoute.of(context)!.settings.arguments as SignedCertificate;
    final certificate = signedCertificate.certificate;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QrImage(
              data: signedCertificate.toString(),
              version: QrVersions.auto,
              size: 320,
              gapless: true,
              errorStateBuilder: (cxt, err) {
                return const Center(
                  child: Text(
                    "Uh oh! Something went wrong while scanning the code",
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            DetailViewCustomText(title: "Name", content: certificate.firstname + " " + certificate.lastname),
            DetailViewCustomText(title: "Vaccination Date", content: certificate.vaccinationDate.toString()),
            DetailViewCustomText(title: "Valid Until", content: certificate.validUntil.toString()),
            DetailViewCustomText(title: "Dose", content: certificate.dose.toString()),
            DetailViewCustomText(title: "Targeted Disease", content: certificate.targetedDisease),
            DetailViewCustomText(title: "Vaccine Type", content: certificate.vaccineType),
            DetailViewCustomText(title: "Product", content: certificate.product),
            DetailViewCustomText(title: "Issuer", content: certificate.issuer),
            DetailViewCustomText(title: "UVCI", content: certificate.uvci),
          ],
        )
      ),
    );
  }
}
