import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/PatientKeysDTO.dart';
import 'package:flutter_app/presentation/components/CustomDialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web3dart/web3dart.dart';

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
      appBar: AppBar(
        title: const Text('Keys'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 5.0, top: 30.0, right: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text("OpenPGP Keys", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
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
            const Text("Ethereum Keys", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            TextField(
              controller: ethAddressController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'ETH Public Key',
                suffixIcon: IconButton(
                  onPressed: () async {
                    await dialog.showQRDialog(
                        context, ethAddressController.text, "ETH Address");
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
              onPressed: fetchKeys,
              child: const Text('Fetch Keys'),
            ),
            ElevatedButton(
              onPressed: sharePublicKeys,
              child: const Text('Share Public Keys'),
            )
          ],
        ),
      ),
    );
  }
}
