import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/user_account_dto.dart';
import 'package:flutter_app/presentation/components/qr_scan.dart';
import 'package:flutter_app/presentation/navigation/routes.gr.dart';
import 'package:provider/provider.dart';

import '../../../domain/auth_provider.dart';
import '../../components/large_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  SignInState createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {
  late final AuthProvider _authProvider;

  @override
  void initState() {
    _authProvider = context.read<AuthProvider>();
    super.initState();
  }

  Future<void> scanUserQR() async {
    UserAccountDTO? user = await scanUser();
    if (user != null) {
      await _authProvider.signIn(user);
      await AutoRouter.of(context).push(const MainRoute());
      print('hello');
    } else {
      //  TODO: Show error
    }
  }

  @override
  Widget build(BuildContext context) {
    return LargeButton(
      onPressed: scanUserQR,
      text: 'Sign In',
    );
  }
}
