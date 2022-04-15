import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/screens/CertificateDetail.dart';
import 'package:flutter_app/presentation/screens/CertificateList.dart';
import 'package:flutter_app/presentation/screens/CertificateVerification.dart';
import 'package:flutter_app/presentation/screens/CreateCertificate.dart';
import 'package:flutter_app/presentation/screens/HomeScreen.dart';
import 'package:flutter_app/presentation/screens/Keys.dart';
import 'package:flutter_app/presentation/screens/PatientDetail.dart';
import 'package:flutter_app/presentation/screens/PatientList.dart';
import 'package:flutter_app/presentation/screens/ScanCertificate.dart';
import 'package:flutter_app/presentation/screens/ScanPatient.dart';
import 'package:flutter_app/presentation/screens/SignIn.dart';
import 'package:flutter_app/presentation/screens/SignUp.dart';
import 'package:flutter_app/presentation/screens/Start.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterSecureStorage _localStorage = const FlutterSecureStorage();
  String _initialRoute = '/auth';

  _MyAppState() {
    _localStorage.containsKey(key: 'ethPrivateKey').then((isAuthenticated) {
      setState(() {
        _initialRoute = isAuthenticated ? '/' : '/auth';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: _initialRoute,
      routes: {
        '/': (context) => const HomeScreen(),
        '/certificate-list': (context) => CertificateList(vaccineList: []),
        '/certificate-list/certificate': (context) => const CertificateDetail(),
        '/patients': (context) => const PatientList(),
        '/patients/patient': (context) => const PatientDetail(),
        '/create-certificate': (context) => const CreateCertificate(),
        '/create-certificate/scan-patient': (context) => const ScanPatient(),
        '/scan-certificate': (context) => const ScanCertificate(),
        '/keys': (context) => const Keys(),
        '/certificate-verification': (context) => const CertificateVerification(),
        '/auth': (context) => const Start(),
        '/auth/certificate': (context) => const CertificateDetail(),
        '/auth/sign-up': (context) => const SignUp(),
        '/auth/sign-in': (context) => const SignIn(),
        '/auth/scan-certificate': (context) => const ScanCertificate(),
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
  var keyOptions = KeyOptions()..rsaBits = 1024;
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
