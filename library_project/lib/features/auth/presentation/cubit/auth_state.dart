part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity userEntity;

  const AuthSuccess({required this.userEntity});
}

class AuthError extends AuthState {
  final String messege;

  const AuthError({required this.messege});
}
