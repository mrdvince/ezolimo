import '../http/http_client.dart';
import '../models/user_model.dart';

class UserRepository {
  // signin with email and password and return token
  signIn(email, password) async {
    final rawResponse = await getAuthTokenReq(email: email, password: password);
    if (rawResponse != '') {
      final authToken = authTokenFromJson(rawResponse);
      return authToken.accessToken;
    }
    // return rawResponse;
  }
}
