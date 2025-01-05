// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/auth/presentation/pages/sign_in_page.dart';

import 'package:library_project/features/profile_management/presentation/cubit/profile_cubit.dart';
import 'package:library_project/features/rental_management/presentation/cubit/rental_management_cubit.dart';

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
    context.read<ProfileCubit>().getUserProfile();
    context
        .read<RentalManagementCubit>()
        .fetchRentedBooks(widget.userId); // Арендадагы китептерди жүктөө
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Профиль',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
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
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          return BlocBuilder<RentalManagementCubit, RentalManagementState>(
            builder: (context, bookState) {
              // Жүктөө абалын текшерүү
              bool isLoading = profileState is ProfileLoading ||
                  bookState is RentalManagementLoading;

              return Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<ProfileCubit>().getUserProfile();
                  },
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _buildProfileContent(profileState, bookState),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProfileContent(
      ProfileState profileState, RentalManagementState bookState) {
    if (profileState is ProfileError) {
      return Center(child: Text('${profileState.message}  Ката чыкты'));
    } else if (profileState is ProfileLoaded) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4.3,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    profileState.user.userName ?? 'UserName',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  profileState.user.email,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _buildBookList(bookState),
          ),
        ],
      );
    }
    return const Text('Ката чыкты');
  }

  Widget _buildBookList(RentalManagementState state) {
    if (state is RentalManagementFailure) {
      return const Center(child: Text('Error: Something went wrong :) '));
    } else if (state is RentalManagementSuccess) {
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
              context
                  .read<RentalManagementCubit>()
                  .returnBook(book.id!, userId);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${book.title} удален!')),
              );
            },
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
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
                  context
                      .read<RentalManagementCubit>()
                      .returnBook(book.id!, userId);
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
