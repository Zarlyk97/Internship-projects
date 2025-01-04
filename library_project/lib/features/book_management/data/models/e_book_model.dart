import 'package:library_project/features/book_management/domain/entities/book_model.dart';

class EBook extends Book {
  final double fileSize; //mg
  final String format; // pdf
  EBook(
      {required super.title,
      required super.author,
      required super.genre,
      required super.copies,
      required super.isRented,
      required this.fileSize,
      required this.format});
}
