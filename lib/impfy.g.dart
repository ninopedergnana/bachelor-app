// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"address","name":"doctor","type":"address"}],"name":"addDoctor","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes","name":"ipfsHash","type":"bytes"},{"internalType":"address","name":"patient","type":"address"}],"name":"addCertificate","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"patient","type":"address"}],"name":"getCertificates","outputs":[{"internalType":"bytes[]","name":"","type":"bytes[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"doctor","type":"address"}],"name":"invalidateDoctor","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
    'Impfy');

class Impfy extends _i1.GeneratedContract {
  Impfy(
      {required _i1.EthereumAddress address,
      required _i1.Web3Client client,
      int? chainId})
      : super(_i1.DeployedContract(_contractAbi, address), client, chainId);

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addDoctor(_i1.EthereumAddress doctor,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '4780468f'));
    final params = [doctor];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addCertificate(
      _i2.Uint8List ipfsHash, _i1.EthereumAddress patient,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '7c5a1bdb'));
    final params = [ipfsHash, patient];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<_i2.Uint8List>> getCertificates(_i1.EthereumAddress patient,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'f1c49c62'));
    final params = [patient];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<_i2.Uint8List>();
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> invalidateDoctor(_i1.EthereumAddress doctor,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, 'b86a9c5e'));
    final params = [doctor];
    return write(credentials, transaction, function, params);
  }
}
