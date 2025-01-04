import 'package:library_project/features/book_management/domain/entities/book_model.dart';

class AudioBook extends Book {
  final double duration; // Hours
  final String narrator; // рассказчик

  AudioBook({
    required super.id,
    required super.title,
    required super.author,
    required super.genre,
    required super.copies,
    required super.isRented,
    required this.duration,
    required this.narrator,
  });
}
