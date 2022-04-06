import 'package:flutter/material.dart';
import 'package:flutter_app/screens/CertificateDetail.dart';
import 'package:flutter_app/screens/CertificateList.dart';
import 'package:flutter_app/screens/HomeScreen.dart';
import 'package:flutter_app/screens/CertificateVerification.dart';
import 'package:flutter_app/screens/CreateCertificate.dart';
import 'package:flutter_app/screens/PatientDetail.dart';
import 'package:flutter_app/screens/PatientList.dart';
import 'package:flutter_app/screens/ScanCertificate.dart';
import 'package:flutter_app/screens/SignIn.dart';
import 'package:flutter_app/screens/SignUp.dart';
import 'package:flutter_app/screens/Start.dart';
import 'package:http/http.dart';
import 'package:openpgp/openpgp.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_app/models/Vaccine.dart';

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
      initialRoute: '/start',
      routes: {
        '/': (context) => const HomeScreen(),
        '/start': (context) => const Start(),
        '/certificate-list': (context) => CertificateList(vaccineList: [
          Vaccine(product: "product 1", uvci: "", lastname: "Olgiati 1", firstname: "Carlos", manufacturer: "", issuer: "", targetedDisease: "", countryOfVaccination: "", dose: 0, vaccinationDate: DateTime.now(), vaccineType: "", validUntil: DateTime.now()),
          Vaccine(product: "product 2", uvci: "", lastname: "Olgiati 2", firstname: "Carlos", manufacturer: "", issuer: "", targetedDisease: "", countryOfVaccination: "", dose: 0, vaccinationDate: DateTime.now(), vaccineType: "", validUntil: DateTime.now()),
          Vaccine(product: "product 3", uvci: "", lastname: "Olgiati 3", firstname: "Carlos", manufacturer: "", issuer: "", targetedDisease: "", countryOfVaccination: "", dose: 0, vaccinationDate: DateTime.now(), vaccineType: "", validUntil: DateTime.now()),
          Vaccine(product: "product 4", uvci: "", lastname: "Olgiati 4", firstname: "Carlos", manufacturer: "", issuer: "", targetedDisease: "", countryOfVaccination: "", dose: 0, vaccinationDate: DateTime.now(), vaccineType: "", validUntil: DateTime.now()),
          Vaccine(product: "product 5", uvci: "", lastname: "Olgiati 5", firstname: "Carlos", manufacturer: "", issuer: "", targetedDisease: "", countryOfVaccination: "", dose: 0, vaccinationDate: DateTime.now(), vaccineType: "", validUntil: DateTime.now())
        ]),
        '/certificate': (context) => CertificateDetail(),
        '/patients': (context) => const PatientList(),
        '/patient': (context) => const PatientDetail(),
        '/create-certificate': (context) => const CreateCertificate(),
        '/sign-up': (context) => const SignUp(),
        '/sign-in': (context) => const SignIn(),
        '/scan-certificate': (context) => const ScanCertificate(),
        '/certificate-verification': (context) => const CertificateVerification(),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _eth() async {
    var privateKey = '';
    var encryptedCertificate = 'flutter-cert';
    var certificateHash = 'flutter-hash';
    var patient =
        EthereumAddress.fromHex('0x1bAeC083E3002e084129Ca59280624bFe6B0303a');
    var credentials = EthPrivateKey.fromHex(privateKey);
    var contractAddress =
        EthereumAddress.fromHex('0xb58d3d11966CCeB725e39C3d6D0d383Bf3F1cec3');
    var rpcUrl =
        'https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161';
    var client = Web3Client(rpcUrl, Client());
    var impfy = Impfy(address: contractAddress, client: client);
    var certificates = await impfy.getCertificates(
        EthereumAddress.fromHex('0x1bAeC083E3002e084129Ca59280624bFe6B0303a'));
    // var message = await impfy.addCertificate(encryptedCertificate, certificateHash, patient, credentials: credentials);
    // print('message: ' + message);
    for (var value in certificates) {
      print(value);
    }
    // var random = Random.secure();
    // EthPrivateKey wallet = EthPrivateKey.createRandom(random);
    // print(wallet.privateKeyInt);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FutureBuilder(
                future: getKeys(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.toString());
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _eth,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

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
