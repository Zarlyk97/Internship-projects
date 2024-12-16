import 'package:library_project/features/library_management/domain/entities/book_model.dart';

class BookModel extends Book {
  BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.genre,
    required super.copies,
  });
  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        genre: json['genre'],
        copies: json['copies'],
      );
  tojson() => {
        'id': id,
        'title': title,
        'author': author,
        'genre': genre,
        'copies': copies,
      };
}
