import 'dart:convert';

class User {
  final int? user_id;
  final String? firstname;
  final String? lastname;
  final String username;
  final String password;
  final String? mobilehp;

  User({
    this.user_id,
    this.firstname,
    this.lastname,
    required this.username,
    required this.password,
    this.mobilehp
  });
  // Convert a Brand into a Map. The keys must correspond to the names of the
  // columns in the database.

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'password': password,
      'mobilehp': mobilehp
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      user_id: map['user_id']?.toInt() ?? 0,
      firstname: map['firstname'] ?? "",
      lastname: map['lastname'] ?? "",
      username: map['username'] ?? "",
      password: map['password'] ?? "",
      mobilehp: map['mobilehp'] ?? "",
    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source));
  // Implement toString to make it easier to see information about
  // each brandd when using the print statement.

  @override
  String toString() { return
      '''User( 
      user_id: $user_id,
      firstname: $firstname,
      lastname: $lastname,
      username: $username,
      password: $password)''';}
}
