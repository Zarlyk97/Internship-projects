import 'package:library_project/features/auth/domain/entities/user_entity.dart';
import 'package:library_project/features/profile_management/domain/repositories/profile_repository.dart';

class GetUserProfileUseCase {
  final ProfileRepository _authRepository;

  GetUserProfileUseCase(this._authRepository);
  Future<UserEntity> call() async {
    return await _authRepository.getUserProfile();
  }
}
