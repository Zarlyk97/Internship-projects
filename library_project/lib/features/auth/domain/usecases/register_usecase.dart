import 'package:library_project/features/auth/domain/entities/user_entinty.dart';
import 'package:library_project/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository _authRepository;

  RegisterUsecase(this._authRepository);
  Future<User> call(String fullname, String email, String password) async {
    return await _authRepository.register(email, password, fullname);
  }
}
