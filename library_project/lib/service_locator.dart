import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:library_project/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:library_project/features/auth/domain/usecases/login_usecase.dart';
import 'package:library_project/features/auth/domain/usecases/register_usecase.dart';
import 'package:library_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:library_project/features/library_management/data/repositories/book_repository_impl.dart';
import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';
import 'package:library_project/features/library_management/domain/usecases/fetch_books_usecase.dart';
import 'package:library_project/features/library_management/presentation/cubit/book_cubit.dart';

import 'features/auth/domain/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthCubit(sl(), sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => FirebaseAuthRepository(firebaseAuth: FirebaseAuth.instance));

  sl.registerLazySingleton(() => LoginUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUsecase(sl<AuthRepository>()));

  sl.registerFactory(() => BookCubit(
        sl(),
      ));
  sl.registerLazySingleton<BookRepository>(
      () => BookRepositoryImpl(firestore: sl()));
  sl.registerLazySingleton(() => FetchBookUsecase(sl()));
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}
