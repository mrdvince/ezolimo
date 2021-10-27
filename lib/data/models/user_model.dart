import 'dart:convert';

AuthToken authTokenFromJson(String str) => AuthToken.fromJson(json.decode(str));

String authTokenToJson(AuthToken data) => json.encode(data.toJson());

class AuthToken {
  AuthToken({
    required this.accessToken,
    required this.tokenType,
  });

  String accessToken;
  String tokenType;

  factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
      };
}
