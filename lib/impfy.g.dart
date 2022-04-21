// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"string","name":"certificateHash","type":"string"},{"indexed":false,"internalType":"address","name":"doctor","type":"address"},{"indexed":false,"internalType":"address","name":"patient","type":"address"}],"name":"Vaccine","type":"event"},{"inputs":[{"internalType":"address","name":"doctor","type":"address"}],"name":"addDoctor","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"certificateHash","type":"string"},{"internalType":"string","name":"ipfsHash","type":"string"},{"internalType":"address","name":"patient","type":"address"}],"name":"addCertificate","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"patient","type":"address"}],"name":"getCertificates","outputs":[{"components":[{"internalType":"string","name":"certificateHash","type":"string"},{"internalType":"string","name":"ipfsHash","type":"string"},{"internalType":"uint256","name":"blockNumber","type":"uint256"}],"internalType":"struct Impfy.CertificateDTO[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"doctor","type":"address"}],"name":"invalidateDoctor","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"certificateHash","type":"string"}],"name":"invalidateCertificate","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"certificateHash","type":"string"}],"name":"isValidCertificate","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"}]',
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
      String certificateHash, String ipfsHash, _i1.EthereumAddress patient,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '362846dc'));
    final params = [certificateHash, ipfsHash, patient];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getCertificates(_i1.EthereumAddress patient,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'f1c49c62'));
    final params = [patient];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<dynamic>();
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

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> invalidateCertificate(String certificateHash,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '24f349f9'));
    final params = [certificateHash];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> isValidCertificate(String certificateHash,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, 'b5164b38'));
    final params = [certificateHash];
    final response = await read(function, params, atBlock);
    return (response[0] as bool);
  }

  /// Returns a live stream of all Vaccine events emitted by this contract.
  Stream<Vaccine> vaccineEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('Vaccine');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return Vaccine(decoded);
    });
  }
}

class Vaccine {
  Vaccine(List<dynamic> response)
      : certificateHash = (response[0] as String),
        doctor = (response[1] as _i1.EthereumAddress),
        patient = (response[2] as _i1.EthereumAddress);

  final String certificateHash;

  final _i1.EthereumAddress doctor;

  final _i1.EthereumAddress patient;
}
