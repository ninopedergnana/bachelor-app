import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/screens/other_screens/CertificateDetail.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/CertificateList.dart';
import 'package:flutter_app/presentation/screens/other_screens/CertificateVerification.dart';
import 'package:flutter_app/presentation/screens/other_screens/CreateCertificate.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/HomeScreen.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/Keys.dart';
import 'package:flutter_app/presentation/screens/other_screens/PatientDetail.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/ScanCertificate.dart';
import 'package:flutter_app/presentation/screens/other_screens/PatientList.dart';
import 'package:flutter_app/presentation/screens/other_screens/ScanPatient.dart';
import 'package:flutter_app/presentation/screens/other_screens/SignIn.dart';
import 'package:flutter_app/presentation/screens/other_screens/SignUp.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/Start.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: _initialRoute,
      home: const MyStatefulWidget(),
      routes: {
        '/certificate-list': (context) => const CertificateList(),
        '/certificate-list/certificate': (context) => const CertificateDetail(),
        '/patients': (context) => const PatientList(),
        '/patients/patient': (context) => const PatientDetail(),
        '/create-certificate': (context) => const CreateCertificate(),
        '/create-certificate/scan-patient': (context) => const ScanPatient(),
        '/scan-patient': (context) => const ScanPatient(),
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

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 2; //home screen

  //bottom navigation bar widgets
  static const List<Widget> _widgetOptions = <Widget>[
    Keys(),
    CertificateList(),
    HomeScreen(),
    ScanCertificate(),
    Start(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text('Welcome to the Impfy!\n\nLeave while you still can'),
            ),
            ListTile(
              title: const Text('Patients'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushNamed(context, '/patients/patient');
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Navigator.pop(context); should lead to a settings page
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                // Navigator.pop(context); should lead to a settings page
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueGrey,
        elevation: 0,
        iconSize: 25,
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.key_sharp),
            label: 'Keys',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Certificates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Verify',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
