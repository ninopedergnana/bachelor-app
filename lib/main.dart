import 'package:flutter/material.dart';
import 'package:flutter_app/domain/AuthProvider.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/CertificateList.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/Keys.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/ScanCertificate.dart';
import 'package:flutter_app/presentation/screens/navigation_screens/Start.dart';
import 'package:flutter_app/presentation/screens/other_screens/CertificateDetail.dart';
import 'package:flutter_app/presentation/screens/other_screens/CertificateVerification.dart';
import 'package:flutter_app/presentation/screens/other_screens/CreateCertificate.dart';
import 'package:flutter_app/presentation/screens/other_screens/PatientDetail.dart';
import 'package:flutter_app/presentation/screens/other_screens/PatientList.dart';
import 'package:flutter_app/presentation/screens/other_screens/ScanPatient.dart';
import 'package:flutter_app/presentation/screens/other_screens/SignIn.dart';
import 'package:flutter_app/presentation/screens/other_screens/SignUp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterSecureStorage _localStorage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    String initialRoute =
        context.watch<AuthProvider>().isSignedIn ? '/' : '/auth';

    Map<String, Widget Function(BuildContext)> routes =
        context.watch<AuthProvider>().isSignedIn
            ? {
                '/': (context) => const MyStatefulWidget(),
                '/certificate-list': (context) => const CertificateList(),
                '/certificate-list/certificate': (context) =>
                    const CertificateDetail(),
                '/patients': (context) => const PatientList(),
                '/patients/patient': (context) => const PatientDetail(),
                '/create-certificate': (context) => const CreateCertificate(),
                '/create-certificate/scan-patient': (context) =>
                    const ScanPatient(),
                '/scan-patient': (context) => const ScanPatient(),
                '/scan-certificate': (context) => const ScanCertificate(),
                '/keys': (context) => const Keys(),
                '/certificate-verification': (context) =>
                    const CertificateVerification()
              }
            : {
                '/auth': (context) => const Start(),
                '/auth/sign-up': (context) => const SignUp(),
                '/auth/sign-in': (context) => const SignIn(),
                '/auth/scan-certificate': (context) => const ScanCertificate(),
              };
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0; //home screen

  //bottom navigation bar widgets
  static const List<Widget> _widgetOptions = <Widget>[
    CertificateList(),
    Keys(),
    ScanCertificate(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        backgroundColor: Colors.white10,
        elevation: 0,
        centerTitle: true, // todo make title dynamic
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        child: ListView(
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
              title: const Text('Sign Out'),
              onTap: () {
                Navigator.pushNamed(context, '/auth');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.list_outlined),
            icon: Icon(Icons.list),
            label: 'Certificates',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.key_outlined),
            icon: Icon(Icons.key),
            label: 'Keys',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.qr_code_outlined),
            icon: Icon(Icons.qr_code),
            label: 'Verify',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
      ),
    );
  }
}
