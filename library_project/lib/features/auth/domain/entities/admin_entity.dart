import 'package:library_project/features/book_management/domain/entities/book_model.dart';

class AdminEntity extends Book {
  AdminEntity({
    required super.author,
    required super.copies,
    required super.genre,
    required super.id,
    required super.isRented,
    required super.title,
  });
  factory AdminEntity.fromJson(Map<String, dynamic> json) => AdminEntity(
      author: json['author'],
      copies: json['copies'],
      genre: json['genre'],
      id: json['id'],
      isRented: json['isRented'],
      title: json['title']);

  toJson() => {
        "author": author,
        "copies": copies,
        "genre": genre,
        "id": id,
        "isRented": isRented,
        "title": title,
      };
}
