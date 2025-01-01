import 'package:library_project/features/auth/domain/entities/user_entinty.dart';

abstract class ProfileRepository {
  Future<User> getUserProfile();
}
