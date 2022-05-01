import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/SignedCertificate.dart';
import 'package:flutter_app/presentation/navigation/routes.gr.dart';
import 'package:flutter_app/presentation/screens/other_screens/certificate_detail.dart';

import '../../../data/repository/repository.dart';

class CertificateList extends StatefulWidget {
  const CertificateList({Key? key}) : super(key: key);

  @override
  _CertificateListState createState() => _CertificateListState();
}

class _CertificateListState extends State<CertificateList> {
  final Repository repo = Repository();

  List<SignedCertificate> signedCertList = [];

  Future buildSignedCertList() async {
    signedCertList = await repo.getCertificates();
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
        backgroundColor: Colors.blueGrey,
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
              itemCount: signedCertList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(signedCertList[index].certificate.product!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CertificateDetail(),
                        settings: RouteSettings(
                          arguments: signedCertList[index],
                        ),
                      ),
                    );
                  },
                );
              }, // itemBuilder
            );
          } // else case
        }, // builder
      ),
    );
  }
}
