class AuthToken {
  AuthToken({
    required this.accessToken,
    required this.tokenType,
  });

  String accessToken;
  String tokenType;

  AuthToken.fromJson(Map json)
      : accessToken = json["access_token"],
        tokenType = json["token_type"];
}
