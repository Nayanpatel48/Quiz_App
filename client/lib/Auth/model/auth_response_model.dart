//helps when we get response back from the server

class AuthResponseModel {
  //properties of the class
  final String token;
  final int userId;
  final String tokenType;

  //constructor of this class
  AuthResponseModel({
    required this.token,
    required this.userId,
    required this.tokenType,
  });

  //JSON to Dart object conversion
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        token: json['access_token'],
        userId: json['id'],
        tokenType: json['token_type'],
      );
}
