class CertificateDTO {
  final String certificateHash;
  final String ipfsHash;
  final BigInt blockNumber;

  CertificateDTO(
      {required this.certificateHash, required this.ipfsHash, required this.blockNumber});
}
