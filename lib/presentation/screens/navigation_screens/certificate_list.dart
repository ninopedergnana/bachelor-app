import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/signed_certificate.dart';
import 'package:flutter_app/presentation/components/certificate_item.dart';
import 'package:flutter_app/presentation/navigation/routes.gr.dart';

import '../../../data/repository/repository.dart';

class CertificateList extends StatefulWidget {
  const CertificateList({Key? key}) : super(key: key);

  @override
  _CertificateListState createState() => _CertificateListState();
}

class _CertificateListState extends State<CertificateList> {
  final Repository repo = Repository();

  List<SignedCertificate> _certificates = [];

  Future buildSignedCertList() async {
    _certificates = await repo.getCertificates();
    return await repo.getCertificates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AutoRouter.of(context).push(const CreateCertificateRoute());
        },
        elevation: 4,
        focusElevation: 8,
        hoverElevation: 8,
        highlightElevation: 8,
        backgroundColor: const Color(0xff475c6c),
        child: const Icon(
          Icons.add,
          size: 30.0,
        ),
      ),
      body: FutureBuilder(
        future: buildSignedCertList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: _certificates.length,
              itemBuilder: (context, index) {
                return CertificateItem(signedCertificate: _certificates[index]);
              },
            );
          }
        },
      ),
    );
  }
}
