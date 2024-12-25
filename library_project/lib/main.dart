import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:library_project/features/library_management/presentation/cubit/book_cubit.dart';
import 'package:library_project/features/library_management/presentation/pages/splash_screen.dart';
import 'package:library_project/firebase_options.dart';
import 'package:library_project/service_locator.dart';

void main() async {
  await init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => sl<AuthCubit>(),
        ),
        BlocProvider(create: (context) => sl<BookCubit>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
