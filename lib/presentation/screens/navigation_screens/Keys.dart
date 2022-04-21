import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/PatientDTO.dart';
import 'package:flutter_app/presentation/components/CustomDialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/dto/UserAccountDTO.dart';

class Keys extends StatefulWidget {
  const Keys({Key? key}) : super(key: key);

  @override
  KeysState createState() => KeysState();
}

class KeysState extends State<Keys> {
  final FlutterSecureStorage _secureStore = const FlutterSecureStorage();
  final CustomDialog dialog = CustomDialog();

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController pgpPublicKey = TextEditingController();
  final TextEditingController pgpPrivateKey = TextEditingController();
  final TextEditingController ethAddress = TextEditingController();
  final TextEditingController ethPrivateKey = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  loadKeys() async {
    pgpPublicKey.text = (await _secureStore.read(key: 'pgpPublicKey'))!;
    pgpPrivateKey.text = (await _secureStore.read(key: 'pgpPrivateKey'))!;
    ethPrivateKey.text = (await _secureStore.read(key: 'ethPrivateKey'))!;
    ethAddress.text = EthPrivateKey.fromHex(ethPrivateKey.text).address.hex;
    firstName.text = (await _secureStore.read(key: 'firstName'))!;
    lastName.text = (await _secureStore.read(key: 'lastName'))!;
  }

  Future<void> sharePublicKeys() async {
    PatientDTO patientKeys = PatientDTO(
        pgpPublicKey: pgpPublicKey.text,
        ethAddress: ethAddress.text,
        firstName: firstName.text,
        lastName: lastName.text);
    await dialog.showQRDialog(context, patientKeys.toString(), "Public Keys");
  }

  Future<void> exportAllKeys() async {
    UserAccountDTO userKeys = UserAccountDTO(
        pgpPrivateKey: pgpPrivateKey.text,
        pgpPublicKey: pgpPublicKey.text,
        ethPrivateKey: ethPrivateKey.text,
        firstName: firstName.text,
        lastName: lastName.text);
    await dialog.showQRDialog(context, userKeys.toString(), "User Keys");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: loadKeys(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(left: 5.0, top: 30.0, right: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("User Data",
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    TextField(
                      controller: firstName,
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await dialog.showQRDialog(context, firstName.text, 'First Name');
                          },
                          icon: const Icon(Icons.qr_code),
                        ),
                        labelText: 'FirstName',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: lastName,
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await dialog.showQRDialog(context, lastName.text, 'Last Name');
                          },
                          icon: const Icon(Icons.qr_code),
                        ),
                        labelText: 'Last Name',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("OpenPGP Keys",
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    TextField(
                      controller: pgpPublicKey,
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await dialog.showQRDialog(context, pgpPublicKey.text, "PGP Public Key");
                          },
                          icon: const Icon(Icons.qr_code),
                        ),
                        labelText: 'PGP Public Key',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: pgpPrivateKey,
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await dialog.showQRDialog(
                                context, pgpPrivateKey.text, "PGP Private Key");
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
                      controller: ethAddress,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'ETH Address',
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await dialog.showQRDialog(context, ethAddress.text, "ETH Address");
                          },
                          icon: const Icon(Icons.qr_code),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: ethPrivateKey,
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await dialog.showQRDialog(
                                context, ethPrivateKey.text, "ETH Private Key");
                          },
                          icon: const Icon(Icons.qr_code),
                        ),
                        labelText: 'ETH Private Key',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
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
              );
            }
          }),
    );
  }
}
