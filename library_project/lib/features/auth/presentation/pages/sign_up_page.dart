import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:library_project/features/auth/presentation/pages/sign_in_page.dart';
import 'package:library_project/features/book_management/presentation/pages/books_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signInText(),
      appBar: AppBar(title: const Text('Library'), centerTitle: true),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please enter a valid email")),
            );
          } else if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BooksPage()),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _registerText(),
                    const SizedBox(height: 50),
                    _fullNameField(),
                    const SizedBox(height: 20),
                    _enterEmailField(),
                    const SizedBox(height: 20),
                    _passwordField(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () async {
                        final fullName = _fullName.text.trim();
                        final email = _email.text.trim();
                        final password = _password.text.trim();

                        if (!_isValidEmail(email)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please enter a valid email.")),
                          );
                          return;
                        }

                        context
                            .read<AuthCubit>()
                            .register(email, password, fullName);
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
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
  }

  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  Widget _registerText() {
    return const Text(
      "Register",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField() {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        hintText: 'Full Name',
      ),
    );
  }

  Widget _enterEmailField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      controller: _email,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        hintText: 'Enter Email',
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      obscureText: true,
      controller: _password,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        hintText: 'Password',
      ),
    );
  }

  Widget _signInText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Do you have an account?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignInPage()),
            );
          },
          child: const Text(
            'Sign In',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
