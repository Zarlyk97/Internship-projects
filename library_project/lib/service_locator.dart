import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:library_project/features/admin/data/datasources/admin_remote_data_source.dart';
import 'package:library_project/features/admin/data/repositories/admin_repo_impl.dart';
import 'package:library_project/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:library_project/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:library_project/features/auth/domain/usecases/login_usecase.dart';
import 'package:library_project/features/profile_management/data/repositories/get_user_repository.dart';
import 'package:library_project/features/profile_management/domain/repositories/profile_repository.dart';
import 'package:library_project/features/profile_management/domain/usecases/profile_usecase.dart';
import 'package:library_project/features/auth/domain/usecases/register_usecase.dart';
import 'package:library_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:library_project/features/book_management/data/repositories/book_repository_impl.dart';
import 'package:library_project/features/book_management/domain/repositories/book_repository.dart';
import 'package:library_project/features/book_management/domain/usecases/fetch_books_usecase.dart';
import 'package:library_project/features/rental_management/domain/usecases/get_rentedbook_usecase.dart';
import 'package:library_project/features/rental_management/data/repositories/rented_repository_impl.dart';
import 'package:library_project/features/rental_management/domain/repositories/rental_repository.dart';
import 'package:library_project/features/rental_management/domain/usecases/rent_book_usecase.dart';
import 'package:library_project/features/book_management/presentation/cubit/book_cubit.dart';
import 'package:library_project/features/profile_management/presentation/cubit/profile_cubit.dart';
import 'package:library_project/features/rental_management/presentation/cubit/rental_management_cubit.dart';

import 'features/admin/domain/repositories/admin_repo.dart';
import 'features/auth/domain/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///////  Firebase Auth
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerFactory(() => AuthCubit(sl(), sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => FirebaseAuthRepository(firebaseAuth: sl(), firestore: sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUsecase(sl<AuthRepository>()));

  ////////////////// Profile
  sl.registerFactory(() => ProfileCubit(sl()));
  sl.registerLazySingleton<ProfileRepository>(
      () => GetUserRepository(firebaseAuth: sl(), firestore: sl()));
  sl.registerLazySingleton(
      () => GetUserProfileUseCase(sl<ProfileRepository>()));

  ///////////// Rental
  sl.registerFactory(() => RentalManagementCubit(sl(), sl(), sl()));
  sl.registerLazySingleton<RentalRepository>(
      () => RentedRepositoryImpl(firestore: sl()));

  sl.registerLazySingleton(() => RentBookUsecase(sl(), sl()));
  sl.registerLazySingleton(() => GetRentedbookUsecase(sl()));

///////////////// Book
  sl.registerFactory(() => BookCubit(
        sl(),
        sl(),
      ));
  sl.registerLazySingleton<BookRepository>(
      () => BookRepositoryImpl(firestore: sl()));
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FetchBookUsecase(sl()));
////////admin
  sl.registerFactory(() => AdminCubit(
        sl<AdminRepository>(),
      ));

  // Home Page Dependencies
  sl.registerFactory<AdminRemoteDataSource>(() => AdminRemoteDataSourceimpl());
  sl.registerFactory<AdminRepository>(() =>
      AdminRepositoryImpl(adminRemoteDataSource: sl<AdminRemoteDataSource>()));
}
