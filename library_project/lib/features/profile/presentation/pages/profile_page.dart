// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:library_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:library_project/features/library_management/data/models/images_model.dart';
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
    context.read<AuthCubit>().getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Профиль'),
          centerTitle: true,
        ),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AuthError) {
              return Center(child: Text('${state.messege}  Ката чыкты'));
            } else if (state is AuthSuccess) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        state.userEntity.userName ?? 'UserName',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      state.userEntity.email,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<BookCubit, BookState>(
                      builder: (context, state) {
                        if (state is BookStateLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is BookStateFailure) {
                          return const Text('Error: Somethng went wrong :) ');
                        } else if (state is BookStateLoaded) {
                          if (state.books.isEmpty) {
                            return const Center(child: Text('No books rented'));
                          }
                          return Expanded(
                            child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final book = state.books[index];
                                  return ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    tileColor: Colors.grey[200],
                                    contentPadding: const EdgeInsets.all(10),
                                    leading: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                            bookimages[index].image)),
                                    title: Text(book.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17)),
                                    subtitle: Text(" Автор: ${book.author}",
                                        style: const TextStyle(fontSize: 15)),
                                    trailing: TextButton(
                                      onPressed: () {},
                                      child: const Text('Возврщать'),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 10,
                                    ),
                                itemCount: state.books.length),
                          );
                        } else if (state is BookStateFailure) {
                          return const Text('Error: Somethng went wrong :) ');
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              );
            }
            return const Text('Ката чыкты');
          },
        ));
  }
}
