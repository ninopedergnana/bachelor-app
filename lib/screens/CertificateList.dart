import 'package:flutter/material.dart';

class CertificateList extends StatelessWidget {
  const CertificateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
            child: Column(children: <Widget>[
      const Text('Certificate List Screen'),
      ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/certificate');
          },
          child: const Text('Detail')),
      ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/patients');
          },
          child: const Text('Patients')),
      ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/scan-certificate');
          },
          child: const Text('Scan')),
      ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/create-certificate');
          },
          child: const Text('Create'))
    ])));
  }
}
