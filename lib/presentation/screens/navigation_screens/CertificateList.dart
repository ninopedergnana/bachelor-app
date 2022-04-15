import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/SignedCertificate.dart';
import 'package:flutter_app/presentation/screens/other_screens/CertificateDetail.dart';
import '../../../data/repository/Repository.dart';

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
      appBar: AppBar(
        title: const Text('List of Vaccines'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: buildSignedCertList(),
        builder:(context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator()
            );
          } else {
            return ListView.builder(
              itemCount: signedCertList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(signedCertList[index].certificate.product),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CertificateDetail(),
                        settings: RouteSettings(arguments: signedCertList[index])
                      )
                    );
                  },
                );
              } // itemBuilder
            );
          } // else case
        } // builder
      )
    );
  }
}
