// Think of it like international travel.
//     Your Flutter app speaks the language of Dart Objects (like the User class). 🗣️
//     The Server/API speaks the language of JSON. 🌐

// The fromJson and toJson methods are your app's universal translators. They ensure smooth
//communication, prevent misunderstandings (bugs), and keep your application code organized
//and predictable. This entire process is called serialization (toJson) and deserialization
//(fromJson).

class User {
  //properties of the class
  final int id;
  final String username;
  final String email;
  final String hashedPassword;
  final DateTime? createdAt;

  //constructor
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.hashedPassword,
    required this.createdAt,
  });

  //JSON to Dart object converter method
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    username: json['username'],
    email: json['email'],
    hashedPassword: json['hashedPassword'],
    createdAt: json['createdAt'],
  );

  //Dart object to JSON converter method
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'hashedPassword': hashedPassword,
    'createdAt': createdAt,
  };
}
