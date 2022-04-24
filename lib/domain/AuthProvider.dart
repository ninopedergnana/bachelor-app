import 'package:flutter_app/data/dto/UserKeysDTO.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

/// Source: https://pub.dev/packages/provider/example
///
class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStore = const FlutterSecureStorage();
  String? _firstName;
  String? _lastName;
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  void signIn(UserKeysDTO userKeys) async {
    await Future.wait([
      _secureStore.write(key: 'pgpPrivateKey', value: userKeys.pgpPrivateKey),
      _secureStore.write(key: 'pgpPublicKey', value: userKeys.pgpPublicKey),
      _secureStore.write(key: 'ethPrivateKey', value: userKeys.ethPrivateKey)
    ]);

    _isSignedIn = true;
  }
}
