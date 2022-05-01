import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/components/large_button.dart';
import 'package:flutter_app/presentation/screens/other_screens/sign_in.dart';
import 'package:flutter_app/presentation/screens/other_screens/verification.dart';

import '../../navigation/routes.gr.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding:  const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 256),
              LargeButton(
                onPressed: () {
                  AutoRouter.of(context).push(const SignUpRoute());
                },
                text: 'Sign Up',
              ),
              const SizedBox(height: 8),
              const SignIn(),
              const SizedBox(height: 8),
              const Verification(),
            ],
          ),
        ),
      ),
    );
  }
}
