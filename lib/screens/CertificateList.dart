import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Certificate.dart';
import 'package:flutter_app/screens/CertificateDetail.dart';

class CertificateList extends StatelessWidget {
  const CertificateList({Key? key, required this.vaccineList}) : super(key: key);

  final List<Certificate> vaccineList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Vaccines'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: vaccineList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(vaccineList[index].product),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CertificateDetail(),
                      settings: RouteSettings(
                        arguments: vaccineList[index]
                    ),
                  ),
                );
              },
            );
          },
        )
      ),
    );
  }
}

