import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/Person.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openpgp/openpgp.dart';
import 'package:web3dart/credentials.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: const SignUpForm(),
      ),
    );
  }
}

// Create a Form widget.
class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final FlutterSecureStorage _localStorage = const FlutterSecureStorage();
  Person person = Person(firstname: '', lastname: '', email: '', passphrase: '');
  bool? keysGenerated;
  Map keyMap = <String, String>{};

  Future<bool> generateKeys() async {
    EthPrivateKey credentials = EthPrivateKey.createRandom(Random.secure());
    var keyOptions = KeyOptions()..rsaBits = 1024;
    var keyPair1 = await OpenPGP.generate(
        options: Options()
          ..name = person.firstname + person.lastname
          ..email = person.email
          ..passphrase = ''
          ..keyOptions = keyOptions);

    print(keyPair1.publicKey);
    print(keyPair1.privateKey);

    /*
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: openpgp-mobile

xo0EYlTF2AEEALWu5Kmwzha2SvUlD15u6MUzp1DjSmkYnGh1IWYVbr2nVtaNNczA
7nEoS/XniNdKIkRCZ2XujL7V59vsqsOTEWFTV8N0CmAmxIX9vIfboQpIYo3Bq0oS
Ph4YNc43JYxTIHIYe4Xll8solLK/JZue5VX87xO4iYXboGFqTzuhmjudABEBAAHN
BnR0IDx0PsKoBBMBCAAcBQJiVMXYCRAQ9Vj7G3VvBAIbAwIZAQILBwIVCAAA16kE
AGoke4Vn8xjHBXF3QFpOVllf0GdecRaEQoScsl3Uz42tqP3ym2CEd/uQ3G+wbA4v
9UDxel86bUMiepqYroN4eu4+XajomZT02Csd0YFIhwkg5/8GyQmIR1almpUalefP
faDBDQeXmU9d+0ViGkqgUEVBXCMpA+q/ZrFHoW04VR8Nzo0EYlTF2AEEAMss9ldR
isjot5QSEkrf4KFh7GLwds+gvXXSMiNrm2ZLvDlkK7Dm8aHMmsfYX5m97q8j7r7L
mMf8XPbFl90JNhrPcd4DLYh7kigSHtDp1RuYEB8ghAPRteqQoJ2CYxVJDdbDEguy
ywbwj0HyqT81X9lk8lFSM5oB2gpJQwb7cLFBABEBAAHCnwQYAQgAEwUCYlTF2AkQ
EPVY+xt1bwQCGwwAAKL7BABiXfxtMYsiA3Fcvj54xS4QJ3VJ/wSySmDCP1IUHxSJ
1HtBKAfkJC3355MPUFnGjCNe4Trk9bUBuKUQ9c2G++i2UIU0WEB2hIsfDwSEO1PU
CdayRWa3iqzqwKYIQmTfUcjNmL8uUL+OlCjoxEaw/VJ5WbnV19DWPqBcBQ/jP38f
4w==
=5MQv

-----BEGIN PGP PRIVATE KEY BLOCK-----
Version: openpgp-mobile

xcEYBGJUxdgBBAC1ruSpsM4Wtkr1JQ9ebujFM6dQ40ppGJxodSFmFW69p1bWjTXM
wO5xKEv154jXSiJEQmdl7oy+1efb7KrDkxFhU1fDdApgJsSF/byH26EKSGKNwatK
Ej4eGDXONyWMUyByGHuF5ZfLKJSyvyWbnuVV/O8TuImF26Bhak87oZo7nQARAQAB
AAQAiOrVfiA1H56fXKFiNKtmlf64T9gKYqtea8Yhtlnei+SJJ8VhTv3yc6qHnDix
wnUm38QfQg0FWme/hNiVVDAH/sZfn2mdPrqDzFUt2gwokppdefw8/HEIjGX4Ju1X
IG6MI4hWo0EGfdPPxIAPFwNodHuPAdMPTpYiq1jnnE39SU0CAMAQ5MwubaCqBCqW
0MnHSJtxy4NUBtsv1sHjRntkKtv0h6wGxaX3mUf24G8sJRWd36r0AT4kS0dej+JL
K4UoA1MCAPIpN4sn1bn4crx4IQmy/dgWD7sSqvrx0zeiWASp+qfYaBC7FKU7HYKv
o+bTzO35NbmyZQMYUKhp7gq5cUZgV08B/0loPPPTr9Hu629isW6jJwKqqKSIWbzZ
YfrSI8GU5JOYif2/IsbnpI8KGUpFhlrJAjWd7cB/KYdvESyZ3EsSQCugk80GdHQg
PHQ+wqgEEwEIABwFAmJUxdgJEBD1WPsbdW8EAhsDAhkBAgsHAhUIAADXqQQAaiR7
hWfzGMcFcXdAWk5WWV/QZ15xFoRChJyyXdTPja2o/fKbYIR3+5Dcb7BsDi/1QPF6
XzptQyJ6mpiug3h67j5dqOiZlPTYKx3RgUiHCSDn/wbJCYhHVqWalRqV5899oMEN
B5eZT137RWIaSqBQRUFcIykD6r9msUehbThVHw3HwRgEYlTF2AEEAMss9ldRisjo
t5QSEkrf4KFh7GLwds+gvXXSMiNrm2ZLvDlkK7Dm8aHMmsfYX5m97q8j7r7LmMf8
XPbFl90JNhrPcd4DLYh7kigSHtDp1RuYEB8ghAPRteqQoJ2CYxVJDdbDEguyywbw
j0HyqT81X9lk8lFSM5oB2gpJQwb7cLFBABEBAAEAA/4huT7SU4iTvHzsKOu8Xdit
MNHJwlwWLnoEGnWUB4JtwlhltkjCPjMRRiLS1QlZPXtmurIgHS8o0qyjkTyZxbOj
B2rrGq9kQywwbr8/KkjThN9Su+63LXkqp+ZnGCctzmS3aQwwbIlDsiSBoOhplTQI
ZNQVViPqcWueWAfErW/UgQIA/sZs3dItE75t1/JIZGXwF7IC3k3pC7SdyrynwHj+
EeJfdDDWKhAjkxQCnP9xHO9WBtEFPYy4LHeS3c/aDbLwKQIAzCcHZQcJcqRW/KoQ
do+mryIDtPmMuCi9SUcnosvf08BAPqafXy1Bs8xlqU0eHoUvbRYXXB4vOmPWRNoY
bQv7WQH/REUJBSzA6txZFMV/Xafz02mDW26VjUGybQO++zY9a9S56S7+KoXpKe8T
gECF2AvmMS5iTFsbSA5q5Jwkm41ArpcWwp8EGAEIABMFAmJUxdgJEBD1WPsbdW8E
AhsMAACi+wQAYl38bTGLIgNxXL4+eMUuECd1Sf8Eskpgwj9SFB8UidR7QSgH5CQt
9+eTD1BZxowjXuE65PW1AbilEPXNhvvotlCFNFhAdoSLHw8EhDtT1AnWskVmt4qs
6sCmCEJk31HIzZi/LlC/jpQo6MRGsP1SeVm51dfQ1j6gXAUP4z9/H+M=
=Wrdh
-----END PGP PRIVATE KEY BLOCK-----
 */

    keyMap['pgpPublicKey'] = keyPair1.publicKey;
    keyMap['pgpPrivateKey'] = keyPair1.privateKey;
    // keyMap['ethPrivateKey'] = '0x' + credentials.privateKeyInt.toRadixString(16);

    keyMap['ethPrivateKey'] = '0xbc6012f3e6258624371c6172757ce54491d0f76f926c3e216872405be2909730';
    bool success = await storeKeys();

    return success;
  }

  Future<bool> storeKeys() async {
    Future.wait([
      _localStorage.write(key: 'pgpPublicKey', value: keyMap['pgpPublicKey']),
      _localStorage.write(key: 'pgpPrivateKey', value: keyMap['pgpPrivateKey']),
      _localStorage.write(key: 'ethPrivateKey', value: keyMap['ethPrivateKey'])
    ]);
    Map localStorageMap = await _localStorage.readAll();
    return localStorageMap.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400, minHeight: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    filled: false,
                    hintText: 'First Name',
                    labelText: 'First Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      person.firstname = value;
                    });
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your First Name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    filled: false,
                    hintText: 'Last Name',
                    labelText: 'Last Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      person.lastname = value;
                    });
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  // The validator receives the text that the user has entered.
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
                    filled: false,
                    hintText: 'Email',
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    setState(() {
                      person.email = value;
                    });
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    filled: false,
                    hintText: 'Password',
                    labelText: 'Password',
                  ),
                  onChanged: (value) {
                    setState(() {
                      person.passphrase = value;
                    });
                  },
                ),
                const SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && await generateKeys()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Keys Generated")),
                      );
                      Navigator.pushNamed(context, '/');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Key Generation Failed")),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
