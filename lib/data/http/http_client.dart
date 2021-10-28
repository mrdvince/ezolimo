import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../core/constants/urls.dart';

Future getAuthTokenReq(
    {required String email, required String password}) async {
  String url = ServerUrls.baseUrl + ServerUrls.tokenUrlPrefix;
  var map = <String, dynamic>{};
  map['username'] = email;
  map['password'] = password;
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "Application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: map,
    );
    return response.body;
  } catch (e) {
    return '';
  }
}

Future getObjDetPreds(token, String imageFilePath) async {
  String url = ServerUrls.baseUrl + ServerUrls.predictUrlPrefix;

  final mimeTypeData = lookupMimeType(imageFilePath)!.split('/');

  final imageUploadreq =
      http.MultipartRequest('POST', Uri.parse(url + '/?conf_thresh=0.1'));

  final file = await http.MultipartFile.fromPath('file', imageFilePath,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

  imageUploadreq.files.add(file);

  imageUploadreq.headers['Authorization'] = 'Bearer $token';

  try {
    final streamedResponse = await imageUploadreq.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {}
    final data = json.decode(response.body);
    final Map<String, dynamic> mmap = {...data[0], ...data[1]};

    return json.encode(mmap);
  } catch (e) {
    throw 'something happened $e';
  }
}

getGptDetails(String token, question) async {
  String url = ServerUrls.baseUrl + ServerUrls.gptUrl;
  url = '$url/?question=$question';
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      },
    );
    return response.body;
  } catch (e) {
    rethrow;
  }
}

getGptDetailsWithLog(String token, String question, String chatLog) async {
  String url = ServerUrls.baseUrl + ServerUrls.gptUrl;
  url = '$url/?question=$question&chat_log=$chatLog';
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      },
    );
    return response.body;
  } catch (e) {
    rethrow;
  }
}
