import '../http/http_client.dart';

import '../models/user_model.dart';

class UserRepository {
  // signin with email and password and return token
  Future<String> signIn(email, password) async {
    final rawResponse = await getAuthTokenReq(email: email, password: password);
    if (rawResponse != []) {
      final token = rawResponse.map((e) => AuthToken.fromJson(e)).toList();
      return token['access_token'];
    }
    return '';
  }
}
