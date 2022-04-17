import 'package:flutter/material.dart';

class PatientDetail extends StatelessWidget {
  const PatientDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: const Text('Back'))
        ])));
  }
}
