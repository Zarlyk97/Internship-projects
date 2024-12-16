import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_project/features/auth/presentation/pages/sign_in_page.dart';
import 'package:library_project/features/library_management/presentation/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignInPage()),
            );
          },
        ),
        title: const Text(
          'Библиотека',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[350],
            radius: 20,
            child: const Icon(Icons.person),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _genreWidget(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Genre Title',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            _bookWidget(),
          ],
        ),
      ),
    );
  }

////////////////Genre Widget
  Widget _genreWidget() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, indext) {
            return GestureDetector(
              onTap: () => onTabTapped(indext),
              child: SizedBox(
                height: 25,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: _currentIndex == indext
                          ? Colors.black54
                          : Colors.grey[350]),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    child: Center(
                      child: Text(
                        'Популярные',
                        style: TextStyle(
                            color: _currentIndex == indext
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: 10),
    );
  }

  ////////////////Book Widget

  Widget _bookWidget() {
    return Expanded(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 250,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DetailPage())),
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black26),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'https://bookhouse.kg/media/galleryphoto/2021/12/52b2e83f-8f47-41f7-be24-387310ab7681.jpg.600x780_q94.jpg',
                        height: 130,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: Column(
                        children: [
                          const Text(
                            'Бактылуулук формуласы',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                          const Text(
                            'Чубак ажы Жалилов',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: Colors.grey),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(40, 25),
                                  backgroundColor: Colors.blue),
                              onPressed: () {},
                              child: const Center(
                                child: Text(
                                  'Арендa',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
