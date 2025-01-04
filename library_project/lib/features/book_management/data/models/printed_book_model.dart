import 'package:library_project/features/book_management/domain/entities/book_model.dart';

class PrintedBookModel extends Book {
  final int pageCount;
  final String binding; // Hardcover, Paperback
  PrintedBookModel({
    required super.title,
    required super.author,
    required super.genre,
    required super.copies,
    required super.isRented,
    required this.pageCount,
    required this.binding,
  });
}
