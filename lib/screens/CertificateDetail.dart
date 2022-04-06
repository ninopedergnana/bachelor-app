import 'package:flutter/material.dart';
import 'package:flutter_app/models/Vaccine.dart';

class CertificateDetail extends StatelessWidget {
  const CertificateDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Vaccine;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.product),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(args.lastname),
      ),
    );
  }
}
