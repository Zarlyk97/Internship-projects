import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_project/features/book_management/presentation/pages/books_page.dart';
import 'package:library_project/features/audio_books/presentation/pages/home/home_page.dart';
import 'package:library_project/features/profile_management/presentation/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: _currentIndex,
      keepPage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            _currentIndex = value;
            setState(() {});
          },
          children: [
            const HomePage(),
            const BooksPage(),
            ProfilePage(userId: FirebaseAuth.instance.currentUser!.uid)
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            height: 1.6,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            height: 1.6,
          ),
          selectedItemColor: Colors.blueAccent,
          items: [
            BottomNavigationBarItem(
                label: "Главная",
                icon: Icon(
                  Icons.home_outlined,
                  color: _currentIndex == 0 ? Colors.blue : Colors.grey,
                )
                // ignore: deprecated_member_use

                ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books_outlined,
                color: _currentIndex == 1 ? Colors.blue : Colors.grey,
              ),
              label: "Библиотека",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outlined,
                color: _currentIndex == 2 ? Colors.blue : Colors.grey,
              ),
              label: "Профиль",
            ),
          ],
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 10),
      curve: Curves.bounceIn,
    );
  }
}
