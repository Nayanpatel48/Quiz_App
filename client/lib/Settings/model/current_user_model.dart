class CurrentUserModel {
  final int id;
  final String username;
  final String email;

  CurrentUserModel({
    required this.id,
    required this.username,
    required this.email,
  });

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) =>
      CurrentUserModel(
        id: json['id'],
        username: json['username'],
        email: json['email'],
      );
}
