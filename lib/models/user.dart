enum UserType { PARTICULAR, PROFESSIONAL }

class User {
  User(
      {required this.name,
      required this.email,
      required this.phone,
      this.password,
      this.type = UserType.PARTICULAR,
      this.id,
      this.createdAt});

  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  UserType type;
  DateTime? createdAt;
}
