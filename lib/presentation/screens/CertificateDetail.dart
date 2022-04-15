import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/SignedCertificate.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CertificateDetail extends StatelessWidget {
  const CertificateDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signedCertificate = ModalRoute.of(context)!.settings.arguments as SignedCertificate;
    final certificate = signedCertificate.certificate;

    return Scaffold(
      appBar: AppBar(
        title: Text(certificate.product),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QrImage(
            data: certificate.toJson().toString(),
            version: QrVersions.auto,
            size: 320,
            gapless: false,
            errorStateBuilder: (cxt, err) {
              return const Center(
                child: Text(
                  "Uh oh! Something went wrong while scanning the code",
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
          Text(certificate.firstname),
          Text(certificate.lastname),
          Text(certificate.vaccinationDate.toString()),
          Text(certificate.validUntil.toString()),
          Text(certificate.dose.toString()),
          Text(certificate.targetedDisease),
          Text(certificate.vaccineType),
          Text(certificate.product),
          Text(certificate.issuer),
          Text(certificate.uvci),
        ],
      )),
    );
  }
}
