class CurrentUserModel {
  //properties
  final int id;
  final String username;
  final String email;

  //constructor of this class
  CurrentUserModel({
    required this.id,
    required this.username,
    required this.email,
  });

  //JSON to Dart object
  factory CurrentUserModel.fromJson(Map<String, dynamic> json) =>
      CurrentUserModel(
        id: json['id'],
        username: json['username'],
        email: json['email'],
      );
}
