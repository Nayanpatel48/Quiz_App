//helps when we send this to server

class UserLoginModel {
  final String email;
  final String password;

  UserLoginModel({required this.email, required this.password});

  factory UserLoginModel.fromJson(Map<String, dynamic> json) =>
      UserLoginModel(email: json['email'], password: json['hashedPassword']);

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
