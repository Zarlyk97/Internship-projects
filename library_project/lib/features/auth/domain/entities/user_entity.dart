class UserEntity {
  final String id;
  final String email;
  final String? userName;

  UserEntity({
    required this.id,
    required this.email,
    this.userName,
  });
}
