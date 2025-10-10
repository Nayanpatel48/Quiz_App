class UserLoginModel {
  //properties of the class
  final String email;
  final String hashedPassword;

  //constructor of the class
  UserLoginModel({required this.email, required this.hashedPassword});

  //JSON to dart object converter
  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
    email: json['email'],
    hashedPassword: json['hashedPassword'],
  );

  //Dart object to JSON converter
  Map<String, dynamic> toJson() => {
    'email': email,
    'hashedPassword': hashedPassword,
  };
}
