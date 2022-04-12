import 'package:flutter/material.dart';
import 'package:flutter_app/screens/CertificateDetail.dart';
import 'package:flutter_app/screens/CertificateList.dart';
import 'package:flutter_app/screens/HomeScreen.dart';
import 'package:flutter_app/screens/CertificateVerification.dart';
import 'package:flutter_app/screens/CreateCertificate.dart';
import 'package:flutter_app/screens/PatientDetail.dart';
import 'package:flutter_app/screens/PatientList.dart';
import 'package:flutter_app/screens/ScanCertificate.dart';
import 'package:flutter_app/screens/ScanPatient.dart';
import 'package:flutter_app/screens/SignIn.dart';
import 'package:flutter_app/screens/SignUp.dart';
import 'package:flutter_app/screens/Start.dart';
import 'package:http/http.dart';
import 'package:openpgp/openpgp.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_app/domain/model/Certificate.dart';

import 'impfy.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/create-certificate',
      routes: {
        '/': (context) => const HomeScreen(),
        '/start': (context) => const Start(),
        '/certificate-list': (context) =>
            CertificateList(vaccineList: [
              Certificate(product: "product 1",
                  uvci: "",
                  lastname: "Olgiati 1",
                  firstname: "Carlos",
                  manufacturer: "",
                  issuer: "",
                  targetedDisease: "",
                  countryOfVaccination: "",
                  dose: 0,
                  vaccinationDate: DateTime.now(),
                  vaccineType: "",
                  validUntil: DateTime.now()),
              Certificate(product: "product 2",
                  uvci: "",
                  lastname: "Olgiati 2",
                  firstname: "Carlos",
                  manufacturer: "",
                  issuer: "",
                  targetedDisease: "",
                  countryOfVaccination: "",
                  dose: 0,
                  vaccinationDate: DateTime.now(),
                  vaccineType: "",
                  validUntil: DateTime.now()),
              Certificate(
                  product: "product 3",
                  uvci: "",
                  lastname: "Olgiati 3",
                  firstname: "Carlos",
                  manufacturer: "",
                  issuer: "",
                  targetedDisease: "",
                  countryOfVaccination: "",
                  dose: 0,
                  vaccinationDate: DateTime.now(),
                  vaccineType: "",
                  validUntil: DateTime.now()),
              Certificate(product: "product 4",
                  uvci: "",
                  lastname: "Olgiati 4",
                  firstname: "Carlos",
                  manufacturer: "",
                  issuer: "",
                  targetedDisease: "",
                  countryOfVaccination: "",
                  dose: 0,
                  vaccinationDate: DateTime.now(),
                  vaccineType: "",
                  validUntil: DateTime.now()),
              Certificate(product: "product 5",
                  uvci: "",
                  lastname: "Olgiati 5",
                  firstname: "Carlos",
                  manufacturer: "",
                  issuer: "",
                  targetedDisease: "",
                  countryOfVaccination: "",
                  dose: 0,
                  vaccinationDate: DateTime.now(),
                  vaccineType: "",
                  validUntil: DateTime.now())
            ]),
        '/certificate': (context) => const CertificateDetail(),
        '/patients': (context) => const PatientList(),
        '/patient': (context) => const PatientDetail(),
        '/create-certificate': (context) => const CreateCertificate(),
        '/scan-patient': (context) => const ScanPatient(),
        '/sign-up': (context) => const SignUp(),
        '/sign-in': (context) => const SignIn(),
        '/scan-certificate': (context) => const ScanCertificate(),
        '/certificate-verification': (
            context) => const CertificateVerification(),
      },
    );
  }
}

class QRCodeRender extends StatelessWidget {
  const QRCodeRender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: QrImage(data: 'this is a QR code')));
  }
}

/*
  Samples:

Future<String> getKeys() async {
  var keyOptions = KeyOptions()
    ..rsaBits = 1024;
  var keyPair1 = await OpenPGP.generate(
      options: Options()
        ..name = 'test1'
        ..email = 'test1@test.com'
        ..passphrase = 'test'
        ..keyOptions = keyOptions);

  var keyPair2 = await OpenPGP.generate(
      options: Options()
        ..name = 'test2'
        ..email = 'test2@test.com'
        ..passphrase = 'test'
        ..keyOptions = keyOptions);

  var decrypted = 'error';

  var message = await OpenPGP.encrypt(
      'de nino isch blöd', keyPair1.publicKey + keyPair2.publicKey);
  decrypted = await OpenPGP.decrypt(message, keyPair1.privateKey, 'test');

  return decrypted;
}

eth() {
  var wallet = EthPrivateKey.fromInt(BigInt.from(21323910213));
  print(wallet.privateKey);
}

void _eth() async {
  var privateKey = '';
  var encryptedCertificate = 'flutter-cert';
  var certificateHash = 'flutter-hash';
  var patient = EthereumAddress
      .fromHex('0x1bAeC083E3002e084129Ca59280624bFe6B0303a');
  var credentials = EthPrivateKey.fromHex(privateKey);
  var contractAddress = EthereumAddress
      .fromHex('0xb58d3d11966CCeB725e39C3d6D0d383Bf3F1cec3');
  var rpcUrl =
      'https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161';
  var client = Web3Client(rpcUrl, Client());
  var impfy = Impfy(address: contractAddress, client: client);
  var certificates = await impfy.getCertificates(
      EthereumAddress.fromHex('0x1bAeC083E3002e084129Ca59280624bFe6B0303a')
  );
  // var message = await impfy.addCertificate(encryptedCertificate, certificateHash, patient, credentials: credentials);
  // print('message: ' + message);
  for (var value in certificates) {
    print(value);
  }
  // var random = Random.secure();
  // EthPrivateKey wallet = EthPrivateKey.createRandom(random);
  // print(wallet.privateKeyInt);
}

*/