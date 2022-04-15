import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/patients');
                    },
                    child: const Text('Patients')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/certificate-list');
                    },
                    child: const Text('Certificate List')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/auth');
                    },
                    child: const Text('Back to Sign In')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/scan-certificate');
                    },
                    child: const Text('Verify')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/create-certificate');
                    },
                    child: const Text('Create')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/keys');
                    },
                    child: const Text('Keys'))
            ])));
  }
}