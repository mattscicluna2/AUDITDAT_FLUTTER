class User {
  int id = 0;
  String name = '';
  String email = '';

  User(
    this.id,
    this.name,
    this.email,
  );

  User.fromJson(Map<String, dynamic> sessionMap) {
    this.id = sessionMap['id'] ?? 0;
    this.name = sessionMap['name'] ?? '';
    this.email = sessionMap['email'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
