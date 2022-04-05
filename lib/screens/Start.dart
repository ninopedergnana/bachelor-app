import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
          child: Column(children: <Widget>[
        const Text('Start'),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sign-up');
            },
            child: const Text('Sign Up')),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sign-in');
            },
            child: const Text('Sign In'))
      ])),
    );
  }
}
