import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/signed_certificate.dart';
import 'package:intl/intl.dart';

import '../navigation/routes.gr.dart';

class CertificateItem extends StatelessWidget {
  final SignedCertificate signedCertificate;
  final bool isDoctorCertificate;

  const CertificateItem({
    Key? key,
    required this.signedCertificate,
    required this.isDoctorCertificate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = signedCertificate.certificate.validUntil!;
    DateFormat formatter = DateFormat('dd.MM.yyyy');
    final String validDate = formatter.format(date);

    return ListTile(
      title: Text(signedCertificate.certificate.product!),
      onTap: () {
        AutoRouter.of(context).push(
          CertificateDetailRoute(
            signedCertificate: signedCertificate,
            isVerification: isDoctorCertificate,
          ),
        );
      },
      subtitle: Text("Valid Until: " + validDate),
      trailing: Hero(
        tag: signedCertificate.signedHash,
        child: signedCertificate.getQR(),
      ),
    );
  }
}
