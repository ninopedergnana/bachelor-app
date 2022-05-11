import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../navigation/routes.gr.dart';

class PatientDetail extends StatelessWidget {
  const PatientDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white10,
          iconTheme: const IconThemeData(color: Colors.blueGrey),
          elevation: 0,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        AutoRouter.of(context).push(const HomeRoute());
                      },
                      child: const Text('Back'))
        ])));
  }
}
