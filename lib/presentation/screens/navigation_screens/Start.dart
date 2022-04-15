import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Screen'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/auth/sign-up');
                  },
                  child: const Text('Sign Up')
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/auth/sign-in');
                  },
                  child: const Text('Sign In')
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/auth/scan-certificate');
                  },
                  child: const Text('Verify')
              )
      ])),
    );
  }
}
