class Users {
  String? userID;
  String email;
  String password;

  Users({
    this.userID,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'password': password,
    };
  }

  Users.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        password = map['password'];
}
