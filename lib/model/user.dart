class Users {
  String email, password;
  String? name, phone;
  int? id;
  Users(
      {this.id,
      this.name,
      required this.email,
      this.phone,
      required this.password});
}
