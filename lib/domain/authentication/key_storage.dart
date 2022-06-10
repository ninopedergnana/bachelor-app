import 'package:flutter_app/data/dto/user_account_dto.dart';
import 'package:flutter_app/data/repository/repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web3dart/credentials.dart';

/// Source: https://pub.dev/packages/provider/example
class KeyStorage {
  static final KeyStorage _instance = KeyStorage._internal();
  static const FlutterSecureStorage _secureStore = FlutterSecureStorage();
  static final Repository _repository = Repository();
  final String _pgpPrivateKey = 'PGP_PRIVATE_KEY';
  final String _pgpPublicKey = 'PGP_PUBLIC_KEY';
  final String _ethPrivateKey = 'ETH_PRIVATE_KEY';
  final String _firstName = 'FIRST_NAME';
  final String _lastName = 'LAST_NAME';
  final String _isDoctor = 'IS_DOCTOR';

  factory KeyStorage() {
    return _instance;
  }

  KeyStorage._internal();

  Future<String?> getPgpPrivateKey() async {
    return _secureStore.read(key: _pgpPrivateKey);
  }

  Future<String?> getPgpPublicKey() async {
    return _secureStore.read(key: _pgpPublicKey);
  }

  Future<String?> getEthPrivateKey() async {
    return _secureStore.read(key: _ethPrivateKey);
  }

  Future<bool> getIsDoctor() async {
    return (await _secureStore.read(key: _isDoctor)) == 'true';
  }

  Future<bool> isSignedIn() async {
    return _secureStore.containsKey(key: _ethPrivateKey);
  }

  Future deleteKeys() async {
    await _secureStore.deleteAll();
  }

  Future storeKeys(UserAccountDTO user) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(user.ethPrivateKey);
    bool isDoctor = await _repository.isDoctor(credentials.address.hex);

    await Future.wait([
      _secureStore.write(key: _pgpPrivateKey, value: user.pgpPrivateKey),
      _secureStore.write(key: _pgpPublicKey, value: user.pgpPublicKey),
      _secureStore.write(key: _ethPrivateKey, value: user.ethPrivateKey),
      _secureStore.write(key: _firstName, value: user.firstName),
      _secureStore.write(key: _lastName, value: user.lastName),
      _secureStore.write(key: _isDoctor, value: isDoctor.toString())
    ]);
  }

  Future<UserAccountDTO> getKeys() async {
    var pgpPrivateKey = await _secureStore.read(key: _pgpPrivateKey);
    var pgpPublicKey = await _secureStore.read(key: _pgpPublicKey);
    var ethPrivateKey = await _secureStore.read(key: _ethPrivateKey);
    var firstName = await _secureStore.read(key: _firstName);
    var lastName = await _secureStore.read(key: _lastName);

    return UserAccountDTO(
      pgpPrivateKey: pgpPrivateKey!,
      pgpPublicKey: pgpPublicKey!,
      ethPrivateKey: ethPrivateKey!,
      firstName: firstName!,
      lastName: lastName!,
    );
  }
}
