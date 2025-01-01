// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:library_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:library_project/features/library_management/presentation/cubit/book_cubit.dart';
import 'package:library_project/features/library_management/presentation/cubit/book_state.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  const ProfilePage({
    required this.userId,
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getUserProfile();
    context
        .read<BookCubit>()
        .fetchRentedBooks(widget.userId); // Арендадагы китептерди жүктөө
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<BookCubit>().fetchBooks();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Профиль'),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          return BlocBuilder<BookCubit, BookState>(
            builder: (context, bookState) {
              // Жүктөө абалын текшерүү
              bool isLoading =
                  authState is AuthLoading || bookState is BookStateLoading;

              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<AuthCubit>().getUserProfile();
                  },
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _buildProfileContent(authState, bookState),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProfileContent(AuthState authState, BookState bookState) {
    if (authState is AuthError) {
      return Center(child: Text('${authState.messege}  Ката чыкты'));
    } else if (authState is AuthSuccess) {
      return Column(
        children: [
          Center(
            child: Text(
              authState.userEntity.userName ?? 'UserName',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            authState.userEntity.email,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _buildBookList(bookState),
          ),
        ],
      );
    }
    return const Text('Ката чыкты');
  }

  Widget _buildBookList(BookState state) {
    if (state is BookStateFailure) {
      return const Center(child: Text('Error: Something went wrong :) '));
    } else if (state is BookStateLoaded) {
      if (state.books.isEmpty) {
        return const Center(child: Text('Нет книг в аренде'));
      }
      return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final book = state.books[index];
          return Dismissible(
            key: Key(book.id!), // Уникалуу идентификатор
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              final userId = FirebaseAuth.instance.currentUser!.uid;
              context.read<BookCubit>().returnBook(book.id!, userId);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${book.title} удален!')),
              );
            },
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Colors.grey[200],
              contentPadding: const EdgeInsets.all(10),
              leading: Stack(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                        'assets/images/library.png'), // Replace with dynamic image
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(child: Text('${index + 1}')),
                    ),
                  ),
                ],
              ),
              title: Text(book.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Автор: ${book.author}",
                      style: const TextStyle(fontSize: 15)),
                  Text(
                      "Арендован: ${book.rentedDate != null ? book.rentedDate!.toDate().toString() : 'N/A'}",
                      style: const TextStyle(fontSize: 12)),
                  Text(
                      "Возврат: ${book.returnDate != null ? book.returnDate!.toDate().toString() : 'N/A'}",
                      style: const TextStyle(fontSize: 12)),
                  Text("Статус: ${book.status}",
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
              trailing: TextButton(
                onPressed: () {
                  final userId = FirebaseAuth.instance.currentUser!.uid;
                  context.read<BookCubit>().returnBook(book.id!, userId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${book.title} возвращен !')),
                  );
                },
                child: const Text('Возврат'),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: state.books.length,
      );
    }
    return Container();
  }
}
