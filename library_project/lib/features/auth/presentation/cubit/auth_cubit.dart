import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_project/features/auth/domain/entities/user_entinty.dart';
import 'package:library_project/features/auth/domain/usecases/login_usecase.dart';
import 'package:library_project/features/auth/domain/usecases/profile_usecase.dart';
import 'package:library_project/features/auth/domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final GetUserProfileUseCase getUserProfileUseCase;
  AuthCubit(this.getUserProfileUseCase, this.loginUsecase, this.registerUsecase)
      : super(AuthInitial());

  //////////////  register logic
  Future<void> register(String email, String password, String username) async {
    try {
      emit(AuthLoading());

      final user = await registerUsecase.call(email, password, username);
      emit(AuthSuccess(userEntity: user));
    } catch (e) {
      emit(AuthError(messege: 'Error ${e.toString()}'));
    }
  }

////////////  sign In logic
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await loginUsecase.call(email, password);
      emit(AuthSuccess(userEntity: user));
    } catch (e) {
      emit(const AuthError(messege: 'Some error occurred.'));
    }
  }

  Future<void> getUserProfile() async {
    try {
      emit(AuthLoading());
      final user = await getUserProfileUseCase.call();
      emit(AuthSuccess(userEntity: user));
    } catch (e) {
      emit(const AuthError(messege: 'Some error occurred.'));
    }
  }
}
