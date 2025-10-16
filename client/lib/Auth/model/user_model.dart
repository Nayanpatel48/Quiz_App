class User {
  final int? id;
  final String username;
  final String email;
  final String hashedPassword;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.hashedPassword,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    username: json['username'],
    email: json['email'],
    hashedPassword: json['hashedPassword'],
  );

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': hashedPassword,
  };
}
