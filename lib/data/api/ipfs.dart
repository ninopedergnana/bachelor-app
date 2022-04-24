import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class IPFS {
  static final _instance = IPFS._internal();
  final String _baseUrl = 'https://ipfs.infura.io:5001/api/v0/';
  final MediaType _contentType = MediaType('multipart', 'form-fata');

  factory IPFS() {
    return _instance;
  }

  IPFS._internal();

  Future<String> getCertificate(String hash) async {
    Uri url = Uri.parse(_baseUrl + 'cat?arg=$hash');
    Response response = await post(url, encoding: utf8, headers: {'accepts': 'application/json'});

    return response.body;
  }

  Future<String> postCertificate(String certificate) async {
    Uri url = Uri.parse(_baseUrl + 'add?pin=false');
    MultipartRequest request = MultipartRequest('POST', url);

    Uint8List data = Uint8List.fromList(certificate.codeUnits);
    var file = MultipartFile.fromBytes('file', data, contentType: _contentType);
    request.files.add(file);
    var response = await Response.fromStream(await request.send());

    return jsonDecode(response.body)['Hash'];
  }
}
