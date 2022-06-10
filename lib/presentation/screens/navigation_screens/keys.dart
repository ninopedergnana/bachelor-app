import 'package:flutter/material.dart';
import 'package:flutter_app/data/dto/patient_dto.dart';
import 'package:flutter_app/presentation/components/custom_dialog.dart';
import 'package:flutter_app/presentation/components/large_button.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/dto/user_account_dto.dart';
import '../../../domain/authentication/auth_provider.dart';

class Keys extends StatefulWidget {
  const Keys({Key? key}) : super(key: key);

  @override
  KeysState createState() => KeysState();
}

class KeysState extends State<Keys> {
  final CustomDialog dialog = CustomDialog();
  late final AuthProvider _authProvider;
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController pgpPublicKey = TextEditingController();
  final TextEditingController pgpPrivateKey = TextEditingController();
  final TextEditingController ethAddress = TextEditingController();
  final TextEditingController ethPrivateKey = TextEditingController();

  @override
  void initState() {
    _authProvider = AuthProvider();
    super.initState();
  }

  Future loadKeys() async {
    UserAccountDTO user = await _authProvider.getUser();
    pgpPrivateKey.text = user.pgpPrivateKey;
    pgpPublicKey.text = user.pgpPublicKey;
    ethPrivateKey.text = user.ethPrivateKey;
    firstName.text = user.firstName;
    lastName.text = user.lastName;
    ethAddress.text = EthPrivateKey.fromHex(ethPrivateKey.text).address.hex;
  }

  Future<void> sharePublicKeys() async {
    PatientDTO patientKeys = PatientDTO(
        pgpPublicKey: pgpPublicKey.text,
        ethAddress: ethAddress.text,
        firstName: firstName.text,
        lastName: lastName.text);
    await dialog.showQRDialog(context, patientKeys.toString(), "Public Keys & Patient Data");
  }

  Future<void> exportAllKeys() async {
    UserAccountDTO user = UserAccountDTO(
        pgpPrivateKey: pgpPrivateKey.text,
        pgpPublicKey: pgpPublicKey.text,
        ethPrivateKey: ethPrivateKey.text,
        firstName: firstName.text,
        lastName: lastName.text);

    await dialog.showQRDialog(context, user.toString(), "User Keys");
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
                padding: const EdgeInsets.only(left: 10.0, top: 30.0, right: 10.0),
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
                    LargeButton(
                      onPressed: sharePublicKeys,
                      text: 'Share Public Keys & Patient Data',
                    ),
                    const SizedBox(height: 10),
                    LargeButton(
                      onPressed: exportAllKeys,
                      text: 'Export User Keys',
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
