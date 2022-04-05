import 'package:flutter/material.dart';

class PatientList extends StatelessWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
            child: Column(children: <Widget>[
      const Text('Patient List Screen'),
      ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/patient');
          },
          child: const Text('Patient Detail')),
    ])));
  }
}
