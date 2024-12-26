import 'package:library_project/features/auth/domain/entities/user_entinty.dart';
import 'package:library_project/features/auth/domain/repositories/auth_repository.dart';

class GetUserProfileUseCase {
  final AuthRepository _authRepository;

  GetUserProfileUseCase(this._authRepository);
  Future<User> call() async {
    return await _authRepository.getUserProfile();
  }
}
