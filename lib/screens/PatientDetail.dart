import 'package:flutter/material.dart';

class PatientDetail extends StatelessWidget {
  const PatientDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
            child: Column(children: <Widget>[
      const Text('Go back'),
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back'))
    ])));
  }
}
