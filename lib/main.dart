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
  String _initialRoute = '/';

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
        '/certificate-list': (context) => const CertificateList(),
        '/certificate-list/certificate': (context) => const CertificateDetail(),
        '/patients': (context) => const PatientList(),
        '/patients/patient': (context) => const PatientDetail(),
        '/create-certificate': (context) => const CreateCertificate(),
        '/create-certificate/scan-patient': (context) => const ScanPatient(),
        '/scan-certificate': (context) => const ScanCertificate(),
        '/keys': (context) => const Keys(),
        '/certificate-verification': (context) => const CertificateVerification(),
        '/auth': (context) => const Start(),
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
