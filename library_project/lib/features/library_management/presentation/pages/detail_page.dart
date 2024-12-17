// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:library_project/features/library_management/domain/entities/book_model.dart';

class DetailPage extends StatelessWidget {
  final Book book;
  const DetailPage({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Title Book',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(25),
            //   child: Image.asset(
            //     image.toString(),
            //     height: 450,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Text(
              book.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'description',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[40]),
            ),
          ],
        ),
      ),
    );
  }
}
