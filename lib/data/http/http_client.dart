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
