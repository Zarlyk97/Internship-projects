import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/book_management/data/models/book_model.dart';
import 'package:library_project/features/book_management/data/models/images_model.dart';
import 'package:library_project/features/book_management/presentation/cubit/book_cubit.dart';
import 'package:library_project/features/book_management/presentation/cubit/book_state.dart';
import 'package:library_project/features/book_management/presentation/pages/detail_page.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  int _currentIndex = 0;
  List<BookModel> books = [];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    context.read<BookCubit>().fetchBooks();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Библиотека',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<BookCubit>().fetchBooks();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _genreWidget(),
              const SizedBox(
                height: 10,
              ),
              _bookWidget(),
            ],
          ),
        ),
      ),
    );
  }

////////////////Genre Widget
  Widget _genreWidget() {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, state) {
        if (state is BookStateLoading) {
        } else if (state is BookStateFailure) {
          return const Text('Error: Somethng went wrong :) ');
        } else if (state is BookStateLoaded) {
          books = state.books;
        }
        return SizedBox(
          height: 50,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final genres = books[index];

                return GestureDetector(
                  onTap: () {
                    onTabTapped(index);
                  },
                  child: SizedBox(
                    height: 25,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: _currentIndex == index
                              ? Colors.black54
                              : Colors.grey[350]),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: Center(
                          child: Text(
                            genres.genre,
                            style: TextStyle(
                                color: _currentIndex == index
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
              itemCount: books.length),
        );
      },
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
        } else if (state is BookStateFailure) {
          return const Text('Error: Somethng went wrong :) ');
        } else if (state is BookStateLoaded) {
          books = state.books;
        }
        return Expanded(
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 330,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: books.length < bookimages.length
                ? books.length
                : bookimages.length,
            itemBuilder: (context, index) {
              final book = books[index];
              final images = bookimages[index].image;
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      images: images,
                      book: book,
                    ),
                  ),
                ),
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
                                height: 220,
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
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    "${book.copies} шт",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  book.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  book.author,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 25),
                                  backgroundColor: book.copies > 0
                                      ? (book.isRented
                                          ? Colors.amber
                                          : Colors.blue)
                                      : Colors.grey,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                ),
                                onPressed: book.copies > 0
                                    ? () {
                                        final currentUser =
                                            FirebaseAuth.instance.currentUser;
                                        if (currentUser == null) {
                                          showModalBottom(context, book,
                                              ' Пожалуйста, войдите в аккаунт.');
                                          return;
                                        }

                                        final userId = currentUser.uid;

                                        if (!book.isRented) {
                                          context
                                              .read<BookCubit>()
                                              .rentBook(book.id!, userId);
                                        } else {
                                          showModalBottom(context, book,
                                              'Вы уже арендовали книгу ${book.title}.');
                                        }
                                      }
                                    : null,
                                child: Text(
                                  book.copies > 0
                                      ? (book.isRented ? 'В аренде' : 'Аренда')
                                      : 'Нет в наличии',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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

  Future<dynamic> showModalBottom(
      BuildContext context, BookModel book, String text) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => SizedBox(
              width: double.infinity,
              height: 100,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: Colors.grey[300],
                ),
                child: Center(
                  child: Text(
                    '$text ${book.title}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ));
  }
}
