import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/signed_certificate.dart';

import '../navigation/routes.gr.dart';

class CertificateItem extends StatelessWidget {
  final SignedCertificate signedCertificate;

  const CertificateItem({Key? key, required this.signedCertificate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(signedCertificate.certificate.product!),
      onTap: () {
        AutoRouter.of(context).push(
          CertificateDetailRoute(
            signedCertificate: signedCertificate,
          ),
        );
      },
      subtitle: Text(signedCertificate.certificate.validUntil!.toString()),
      trailing: Hero(
        tag: signedCertificate.signedHash,
        child: signedCertificate.getQR(),
      ),
    );
  }
}
