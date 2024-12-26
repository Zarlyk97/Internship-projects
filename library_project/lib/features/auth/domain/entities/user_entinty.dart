class User {
  User({
    required this.id,
    required this.email,
    this.userName,
  });
  final String id;
  final String email;
  final String? userName;
}
