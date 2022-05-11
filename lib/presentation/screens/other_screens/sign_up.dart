import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/authentication/auth_provider.dart';

import '../../navigation/routes.gr.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        elevation: 0,
      ),
      body: const SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late final AuthProvider _authProvider;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    _authProvider = AuthProvider();
    super.initState();
  }

  Future _signUp() async {
    if (_formKey.currentState!.validate()) {
      await _authProvider.signUp(firstName.text, lastName.text, email.text);
      AutoRouter.of(context).push(const HomeRoute());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup Successful!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Key Generation Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            //padding: const EdgeInsets.all(10),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400, minHeight: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    style: const TextStyle(color: Colors.black54),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your First Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(color: Colors.black54),
                      hintStyle: TextStyle(color: Colors.black54),
                      filled: false,
                      hintText: 'First Name',
                      labelText: 'First Name',
                    ),
                    controller: firstName,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    style: const TextStyle(color: Colors.black54),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your First Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.black54),
                      hintStyle: TextStyle(color: Colors.black54),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      filled: false,
                      hintText: "Last Name",
                      labelText: 'Last Name',
                    ),
                    controller: lastName,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    style: const TextStyle(color: Colors.black54),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Email';
                      }

                      // // using regular expression
                      // if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      //     .hasMatch(value)) {
                      //   return "Please enter a valid email address";
                      // }

                      return null;
                    },
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(color: Colors.black54),
                      hintStyle: TextStyle(color: Colors.black54),
                      filled: false,
                      hintText: 'Email',
                      labelText: 'Email',
                    ),
                    controller: email,
                  ),
                  const SizedBox(height: 15.0),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF475c6c))),
                    onPressed: _signUp,
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
