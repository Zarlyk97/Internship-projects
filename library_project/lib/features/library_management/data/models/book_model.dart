import 'package:library_project/features/library_management/domain/entities/book_model.dart';

class BookModel extends Book {
  BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.genre,
    required super.copies,
  });
}
