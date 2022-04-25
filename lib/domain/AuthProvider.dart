import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/dto/UserAccountDTO.dart';
import 'package:flutter_app/domain/authentication/sign_up.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Source: https://pub.dev/packages/provider/example
class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStore = const FlutterSecureStorage();
  String? _firstName;
  String? _lastName;
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  Future signIn(UserAccountDTO user) async {
    await _storeKeys(user.pgpPrivateKey, user.pgpPublicKey, user.ethPrivateKey);

    _firstName = user.firstName;
    _lastName = user.lastName;
    _isSignedIn = true;
  }

  Future signUp(String firstName, String lastName, String email) async {
    var pgpKeyPair = await generatePGPKeyPair('$firstName $lastName', email);
    var ethPrivateKey = await generateETHPrivateKey();

    await _storeKeys(
        pgpKeyPair.privateKey, pgpKeyPair.publicKey, ethPrivateKey);

    _firstName = firstName;
    _lastName = lastName;
    _isSignedIn = true;
  }

  Future signOut() async {
    await _secureStore.deleteAll();
    _isSignedIn = false;
  }

  Future _storeKeys(
      String pgpPrivate, String pgpPublic, String ethPrivate) async {
    await Future.wait([
      _secureStore.write(key: 'pgpPrivateKey', value: pgpPrivate),
      _secureStore.write(key: 'pgpPublicKey', value: pgpPublic),
      _secureStore.write(key: 'ethPrivateKey', value: ethPrivate),
    ]);
  }
}
