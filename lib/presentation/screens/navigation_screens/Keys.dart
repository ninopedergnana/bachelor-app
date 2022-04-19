import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/PatientKeysDTO.dart';
import 'package:flutter_app/domain/model/Certificate.dart';
import 'package:flutter_app/presentation/components/CustomDialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openpgp/openpgp.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/dto/UserKeysDTO.dart';

class Keys extends StatefulWidget {
  const Keys({Key? key}) : super(key: key);

  @override
  KeysState createState() => KeysState();
}

class KeysState extends State<Keys> {
  final FlutterSecureStorage _localStorage = const FlutterSecureStorage();
  final CustomDialog dialog = CustomDialog();

  String pgpPublicKey = '';
  String pgpPrivateKey = '';
  String ethAddress = '';
  String ethPrivateKey = '';

  late TextEditingController pgpPublicKeyController;
  late TextEditingController pgpPrivateKeyController;
  late TextEditingController ethAddressController;
  late TextEditingController ethPrivateKeyController;

  Future<bool> fetchKeys() async {
    pgpPublicKey = (await _localStorage.read(key: 'pgpPublicKey'))!; // null checked with "!"
    pgpPrivateKey = (await _localStorage.read(key: 'pgpPrivateKey'))!; // null checked with "!"
    ethPrivateKey = (await _localStorage.read(key: 'ethPrivateKey'))!; // null checked with "!"
    EthPrivateKey credentials = EthPrivateKey.fromHex(ethPrivateKey);
    pgpPublicKeyController.text = pgpPublicKey;
    pgpPrivateKeyController.text = pgpPrivateKey;
    ethAddressController.text = credentials.address.hex;
    ethPrivateKeyController.text = ethPrivateKey;
    return true;
  }

  Future<void> sharePublicKeys() async {
    pgpPublicKey = (await _localStorage.read(key: 'pgpPublicKey'))!;
    String ethPrivateKey = (await _localStorage.read(key: 'ethPrivateKey'))!;
    String ethAddress = EthPrivateKey.fromHex(ethPrivateKey).address.hex;
    PatientKeysDTO patientKeys = PatientKeysDTO(pgpKey: pgpPublicKey, ethAddress: ethAddress);
    await dialog.showQRDialog(context, patientKeys.toString(), "Public Keys");
  }

  pgpTest() async {
    var keyOptions = KeyOptions()..rsaBits = 512;
    var keyPair1 = await OpenPGP.generate(
        options: Options()
          ..name = 'test'
          ..email = 'test@test.com'
          ..passphrase = ''
          ..keyOptions = keyOptions);
    var keyPair2 = await OpenPGP.generate(
        options: Options()
          ..name = 'test1'
          ..email = 'test1@test.com'
          ..passphrase = ''
          ..keyOptions = keyOptions);
    Certificate certificate = Certificate(
        firstname: 'Carlos',
        lastname: 'Olgiati',
        countryOfVaccination: 'CH',
        dose: 1,
        issuer: 'BAG',
        product: 'Comirnaty',
        manufacturer: 'Pfizer',
        vaccinationDate: DateTime.now(),
        validUntil: DateTime.now(),
        vaccineType: 'mRNA',
        targetedDisease: 'COVID',
        uvci: '123:213:2131231123131');

    var message = certificate.toString();
    var encrypted = await OpenPGP.encryptBytes(
        Uint8List.fromList(message.codeUnits), keyPair1.publicKey + keyPair2.publicKey);

    var encryptArmored = Uint8List.fromList(
        (await OpenPGP.encrypt(message, keyPair1.publicKey + keyPair2.publicKey)).codeUnits);
    var decrypted = await OpenPGP.decryptBytes(encrypted, keyPair1.privateKey, '');

    print(encrypted.length);
    print(encryptArmored.length);
  }

  Future<void> exportAllKeys() async {
    pgpPublicKey = (await _localStorage.read(key: 'pgpPublicKey'))!;
    pgpPrivateKey = (await _localStorage.read(key: 'pgpPrivateKey'))!;
    ethPrivateKey = (await _localStorage.read(key: 'ethPrivateKey'))!;
    UserKeysDTO userKeys = UserKeysDTO(
        pgpPrivateKey: pgpPrivateKey, pgpPublicKey: pgpPublicKey, ethPrivateKey: ethPrivateKey);
    await dialog.showQRDialog(context, userKeys.toString(), "User Keys");
  }

  @override
  void initState() {
    pgpPublicKeyController = TextEditingController(text: pgpPublicKey);
    pgpPrivateKeyController = TextEditingController(text: pgpPublicKey);
    ethAddressController = TextEditingController(text: ethAddress);
    ethPrivateKeyController = TextEditingController(text: ethPrivateKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 5.0, top: 30.0, right: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text("OpenPGP Keys",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            TextField(
              controller: pgpPublicKeyController,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    await dialog.showQRDialog(
                        context, pgpPublicKeyController.text, "PGP Public Key");
                  },
                  icon: const Icon(Icons.qr_code),
                ),
                labelText: 'PGP Public Key',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: pgpPrivateKeyController,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    await dialog.showQRDialog(
                        context, pgpPrivateKeyController.text, "PGP Private Key");
                  },
                  icon: const Icon(Icons.qr_code),
                ),
                labelText: 'PGP Private Key',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Ethereum Keys",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            TextField(
              controller: ethAddressController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'ETH Public Key',
                suffixIcon: IconButton(
                  onPressed: () async {
                    await dialog.showQRDialog(context, ethAddressController.text, "ETH Address");
                  },
                  icon: const Icon(Icons.qr_code),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ethPrivateKeyController,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    await dialog.showQRDialog(
                        context, ethPrivateKeyController.text, "ETH Private Key");
                  },
                  icon: const Icon(Icons.qr_code),
                ),
                labelText: 'ETH Private Key',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pgpTest,
              child: const Text('Fetch Keys'),
            ),
            ElevatedButton(
              onPressed: sharePublicKeys,
              child: const Text('Share Public Keys'),
            ),
            ElevatedButton(
              onPressed: exportAllKeys,
              child: const Text('Export Keys'),
            )
          ],
        ),
      ),
    );
  }
}
