import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_project/features/auth/domain/entities/user_entity.dart';
import 'package:library_project/features/profile_management/domain/usecases/profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  ProfileCubit(this.getUserProfileUseCase) : super(ProfileInitial());
  Future<void> getUserProfile() async {
    try {
      emit(ProfileLoading());
      final user = await getUserProfileUseCase.call();
      emit(ProfileLoaded(user: user));
    } catch (e) {
      emit(const ProfileError(message: 'Some error occurred.'));
    }
  }
}
