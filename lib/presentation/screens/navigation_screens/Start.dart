import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/screens/other_screens/SignIn.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        elevation: 0,
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/auth/sign-up');
            },
            child: const Text('Sign Up')),
        const SignIn(),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/auth/scan-certificate');
            },
            child: const Text('Verify'))
      ])),
    );
  }
}
