import 'package:library_project/features/auth/domain/entities/user_entinty.dart';
import 'package:library_project/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository _authRepository;

  LoginUsecase(this._authRepository);
  Future<User> call(String email, String password) async {
    return await _authRepository.login(email, password);
  }
}
