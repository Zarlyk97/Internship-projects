import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/auth/presentation/pages/sign_in_page.dart';
import 'package:library_project/features/library_management/data/models/images_model.dart';
import 'package:library_project/features/library_management/domain/entities/book_model.dart';
import 'package:library_project/features/library_management/presentation/cubit/book_cubit.dart';
import 'package:library_project/features/library_management/presentation/cubit/book_state.dart';
import 'package:library_project/features/library_management/presentation/pages/detail_page.dart';
import 'package:library_project/features/profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Book> books = [];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    context.read<BookCubit>().loadBooks();
    super.initState();
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
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
                icon: const Icon(Icons.person)),
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
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, state) {
        if (state is BookStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
          // ignore: unnecessary_null_comparison
        } else if (state is BookStateFailure) {
          return const Text('Error: Somethng went wrong :) ');
        } else if (state is BookStateLoaded) {
          books = state.books;
        }
        return Expanded(
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 250,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                              book: books[index],
                            ))),
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
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                bookimages[index].image,
                                height: 130,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              left: 3,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Text(book.copies.toString()),
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          child: Column(
                            children: [
                              Text(
                                book.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              Text(
                                book.author,
                                style: const TextStyle(
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
      },
    );
  }
}
