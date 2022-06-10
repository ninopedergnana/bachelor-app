import 'package:flutter_app/data/dto/user_account_dto.dart';
import 'package:flutter_app/domain/authentication/key_generation.dart';

import 'key_storage.dart';

/// Source: https://pub.dev/packages/provider/example
class AuthProvider {
  static final AuthProvider _instance = AuthProvider._internal();
  static final KeyStorage _keyStorage = KeyStorage();

  factory AuthProvider() {
    return _instance;
  }

  AuthProvider._internal();

  Future signIn(UserAccountDTO user) async {
    await _keyStorage.storeKeys(user);
  }

  Future signUp(String firstName, String lastName, String email) async {
    var pgpKeyPair = await generatePGPKeyPair('$firstName $lastName', email);
    var ethPrivateKey = await generateETHPrivateKey();

    UserAccountDTO user = UserAccountDTO(
      pgpPrivateKey: pgpKeyPair.privateKey,
      pgpPublicKey: pgpKeyPair.publicKey,
      ethPrivateKey: ethPrivateKey,
      firstName: firstName,
      lastName: lastName,
    );

    await _keyStorage.storeKeys(user);
  }

  Future<bool> isDoctor() async {
    return _keyStorage.getIsDoctor();
  }

  Future signOut() async {
    await _keyStorage.deleteKeys();
  }

  Future<UserAccountDTO> getUser() async {
    return _keyStorage.getKeys();
  }
}
