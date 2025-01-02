import 'package:library_project/features/auth/domain/entities/user_entity.dart';
import 'package:library_project/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository _authRepository;

  RegisterUsecase(this._authRepository);
  Future<UserEntity> call(
      String email, String password, String username) async {
    return await _authRepository.register(email, password, username);
  }
}
