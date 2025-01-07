import 'package:flutter/material.dart';
import 'package:library_project/features/admin/presentation/pages/admin_screen.dart';
import 'package:library_project/features/audio_books/presentation/pages/main/splash_screen.dart';

class AdminOrUserPage extends StatelessWidget {
  const AdminOrUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Админ панель или пользователь')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 70),
                      backgroundColor: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminScreen()));
                  },
                  child: const Text(
                    'Админ',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ))),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 70), backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()));
              },
              child: const Text('Пользователь',
                  style: TextStyle(fontSize: 25, color: Colors.white))),
        ],
      ),
    );
  }
}
