import 'package:flutter/material.dart';
import 'package:flutter_app/components/CustomDialog.dart';

class Keys extends StatefulWidget {
  const Keys({Key? key}) : super(key: key);

  @override
  KeysState createState() => KeysState();
}

class KeysState extends State<Keys> {

  final CustomDialog dialog = CustomDialog();

  late TextEditingController pgpPublicKey;
  late TextEditingController pgpPrivateKey;
  late TextEditingController etherPublicKey;
  late TextEditingController etherPrivateKey;

  @override
  void initState() {
    pgpPublicKey = TextEditingController(text: 'pgpPublicKey');
    pgpPrivateKey = TextEditingController(text: 'pgpPrivateKey');
    etherPublicKey = TextEditingController(text: 'etherPublicKey');
    etherPrivateKey = TextEditingController(text: 'etherPrivateKey');
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                "PGP Keys",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)
            ),
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
                    await dialog.showQRDialog(context, pgpPrivateKey.text, "PGP Private Key");
                  },
                  icon: const Icon(Icons.qr_code),
                ),
                labelText: 'PGP Private Key',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
                "Ether Keys",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 15),
            TextField(
              controller: etherPublicKey,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Ether Public Key',
                suffixIcon: IconButton(
                  onPressed: () async {
                    await dialog.showQRDialog(context, etherPublicKey.text, "Ether Public Key");
                  },
                  icon: const Icon(Icons.qr_code),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: etherPrivateKey,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    await dialog.showQRDialog(context, etherPrivateKey.text, "Ether Private Key");
                  },
                  icon: const Icon(Icons.qr_code),
                ),
                labelText: 'Ether Private Key',
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

}