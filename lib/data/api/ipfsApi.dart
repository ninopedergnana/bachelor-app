import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

const String baseUrl = 'https://ipfs.infura.io:5001/api/v0/';

Future<String> getFromIPFS(String hash) async {
  Uri url = Uri.parse(baseUrl + 'cat?arg=$hash');
  var headers = {'accepts': 'application/json'};
  Response response = await post(url, encoding: utf8, headers: headers);

  return response.body;
}

Future<String> storeOnIPFS(String encryptedCertificate) async {
  Uri url = Uri.parse(baseUrl + 'add?pin=false');
  MultipartRequest request = MultipartRequest('POST', url);
  Uint8List bytes = Uint8List.fromList(encryptedCertificate.codeUnits);
  MediaType contentType = MediaType('multipart', 'form-fata');
  MultipartFile file = MultipartFile.fromBytes('file', bytes, contentType: contentType);
  request.files.add(file);
  var response = await Response.fromStream(await request.send());

  return json.decode(response.body)['Hash'];
}