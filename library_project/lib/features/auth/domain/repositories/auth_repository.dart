import 'package:library_project/features/auth/domain/entities/user_entinty.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String fullName, String email, String password);
  Future<void> signOut();
}
