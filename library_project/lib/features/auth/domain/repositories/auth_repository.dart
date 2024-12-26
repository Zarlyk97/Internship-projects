import 'package:library_project/features/auth/domain/entities/user_entinty.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String userName);

  Future<User> getUserProfile();
}
