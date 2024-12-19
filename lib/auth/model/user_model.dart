class User {
  int? userId; // Birincil anahtar, otomatik artan olduğu için nullable
  String firstName;
  String lastName;
  String email;
  String password;

  // Constructor
  User({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  // JSON'dan User modeline dönüştürme (Map -> User)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
    );
  }

  // User modelinden JSON'a dönüştürme (User -> Map)
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    };
  }
}
