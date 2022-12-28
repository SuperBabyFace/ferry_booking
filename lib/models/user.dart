import 'dart:convert';

class User {
  //final int? id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  User({
    //this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });
  // Convert a Brand into a Map. The keys must correspond to the names of the
  // columns in the database.
  
  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'first name': firstname,
      'last name': lastname,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      //id: map['id']?.toInt() ?? 0,
      firstname: map['first name'] ?? '',
      lastname: map['last name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source));
  // Implement toString to make it easier to see information about
  // each brandd when using the print statement.
  @override
  String toString() =>
      'UserPage( name: $firstname,firstname: $lastname,lastname: $email,email: $password)';
}
