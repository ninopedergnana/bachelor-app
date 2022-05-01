import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/data/dto/user_account_dto.dart';
import 'package:flutter_app/domain/authentication/sign_up.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Source: https://pub.dev/packages/provider/example
class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStore = const FlutterSecureStorage();
  final String _pgpPrivateKey = 'PGP_PRIVATE_KEY';
  final String _pgpPublicKey = 'PGP_PUBLIC_KEY';
  final String _ethPrivateKey = 'ETH_PRIVATE_KEY';
  final String _firstName = 'FIRST_NAME';
  final String _lastName = 'LAST_NAME';

  Future signIn(UserAccountDTO user) async {
    await _storeKeys(user);
  }

  Future signUp(String firstName, String lastName, String email) async {
    var pgpKeyPair = await generatePGPKeyPair('$firstName $lastName', email);
    var ethPrivateKey = await generateETHPrivateKey();

    UserAccountDTO user = UserAccountDTO(
        pgpPrivateKey: pgpKeyPair.privateKey,
        pgpPublicKey: pgpKeyPair.publicKey,
        ethPrivateKey: ethPrivateKey,
        firstName: firstName,
        lastName: lastName);

    await _storeKeys(user);
  }

  Future signOut() async {
    await _secureStore.deleteAll();
  }

  Future _storeKeys(UserAccountDTO user) async {
    await Future.wait([
      _secureStore.write(key: _pgpPrivateKey, value: user.pgpPrivateKey),
      _secureStore.write(key: _pgpPublicKey, value: user.pgpPublicKey),
      _secureStore.write(key: _ethPrivateKey, value: user.ethPrivateKey),
      _secureStore.write(key: _firstName, value: user.firstName),
      _secureStore.write(key: _lastName, value: user.lastName),
    ]);
  }
}
