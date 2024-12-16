import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:library_project/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:library_project/features/auth/domain/usecases/login_usecase.dart';
import 'package:library_project/features/auth/domain/usecases/register_usecase.dart';
import 'package:library_project/features/auth/presentation/cubit/auth_cubit.dart';

import 'features/auth/domain/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthCubit(sl(), sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => FirebaseAuthRepository(firebaseAuth: FirebaseAuth.instance));

  sl.registerLazySingleton(() => LoginUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUsecase(sl<AuthRepository>()));
}
