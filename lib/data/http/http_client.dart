import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../core/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    var decodedJson = jsonDecode(response.body);
    return decodedJson;
  } catch (e) {
    return [];
  }
}

getObjDetPreds(token, String imageFilePath) async {
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

    final responseData = json.decode(response.body);
  } catch (e) {}
  return '';
}
