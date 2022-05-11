import 'dart:math';

import 'package:openpgp/openpgp.dart';
import 'package:web3dart/web3dart.dart';

Future<KeyPair> generatePGPKeyPair(String name, String email) async {
  var keyOptions = KeyOptions()..rsaBits = 512;
  var keyPair = await OpenPGP.generate(
      options: Options()
        ..name = name
        ..email = email
        ..passphrase = ''
        ..keyOptions = keyOptions);
  return keyPair;
}

Future<String> generateETHPrivateKey() async {
  EthPrivateKey credentials = EthPrivateKey.createRandom(Random.secure());
  return '0x' + credentials.privateKeyInt.toRadixString(16);
}
