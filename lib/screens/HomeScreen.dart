import 'package:flutter/material.dart';

class CertificateList extends StatelessWidget {
  const CertificateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                      Navigator.pushNamed(context, '/certificate-verification');
                    },
                    child: const Text('Certificate Verification')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/start');
                    },
                    child: const Text('Back to Sign In')),
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
