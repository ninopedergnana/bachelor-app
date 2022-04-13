import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Certificate.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CertificateDetail extends StatelessWidget {
  const CertificateDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Certificate;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.product),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QrImage(
              data: args.toJson().toString(),
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
            Text(args.firstname),
            Text(args.lastname),
            Text(args.vaccinationDate.toString()),
            Text(args.validUntil.toString()),
            Text(args.dose.toString()),
            Text(args.targetedDisease),
            Text(args.vaccineType),
            Text(args.product),
            Text(args.issuer),
            Text(args.uvci),
          ],
        )
      ),
    );
  }
}
