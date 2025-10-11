//helps when we send this to server

class UserLoginModel {
  //properties of the class
  final String email;
  final String password;

  //constructor of the class
  UserLoginModel({required this.email, required this.password});

  //JSON to dart object converter
  factory UserLoginModel.fromJson(Map<String, dynamic> json) =>
      UserLoginModel(email: json['email'], password: json['hashedPassword']);

  //Dart object to JSON converter
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
