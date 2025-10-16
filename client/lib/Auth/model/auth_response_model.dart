//helps when we get response back from the server

class AuthResponseModel {
  final String token;
  final int userId;
  final String tokenType;

  AuthResponseModel({
    required this.token,
    required this.userId,
    required this.tokenType,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        token: json['access_token'],
        userId: json['id'],
        tokenType: json['token_type'],
      );
}
