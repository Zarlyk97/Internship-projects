import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:library_project/features/auth/domain/entities/admin_entity.dart';
import 'package:uuid/uuid.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({
    super.key,
  });

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController authorController = TextEditingController();

  final TextEditingController copiesController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isRented = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Админ панель'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLines: 1,
                    controller: authorController,
                    decoration: const InputDecoration(labelText: 'Author'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Описание обязательно";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: 1,
                    controller: copiesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Copies'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Описание обязательно";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: 1,
                    controller: genreController,
                    decoration: const InputDecoration(labelText: 'Genre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Описание обязательно";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: 1,
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Book Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Описание обязательно";
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isRented,
                        onChanged: (bool? value) {
                          setState(() {
                            isRented = value!;
                          });
                        },
                      ),
                      const Text('Is rented?'),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(350, 50),
                        backgroundColor: Colors.blue),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final author = authorController.text;
                        final copies = copiesController.hashCode;
                        final genre = genreController.text;
                        final title = titleController.text;
                        context.read<AdminCubit>().addBooks(AdminEntity(
                              author: author,
                              copies: copies,
                              genre: genre,
                              id: const Uuid().v4(),
                              isRented: isRented,
                              title: title,
                            ));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Успешно отправлено! $title"),
                          ),
                        );
                        authorController.clear();
                        copiesController.clear();
                        genreController.clear();
                        titleController.clear();
                        setState(() {
                          isRented = false;
                        });
                      }
                    },
                    child: const Text(
                      'Добавить книгу',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
