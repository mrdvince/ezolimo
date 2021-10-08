import 'package:http/http.dart' as http;
import 'dart:convert';

Future loginUser(String email, String password) async {
  String url = 'https://prod.api.nebo.africa/api/v1/login/access-token';
  var map = <String, dynamic>{};
  map['username'] = email;
  map['password'] = password;

  final response = await http.post(
    Uri.parse(url),
    headers: {
      "Accept": "Application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: map,
  );
  var convertedDataToJson = jsonDecode(response.body);
  return convertedDataToJson;
}
