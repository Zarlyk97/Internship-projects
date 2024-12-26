import 'package:library_project/features/library_management/domain/entities/book_model.dart';

class BookModel extends Book {
  BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.genre,
    required super.copies,
    required super.isRented,
  });
  factory BookModel.fromJson(Map<String, dynamic> json, String id) => BookModel(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        genre: json['genre'],
        copies: json['copies'] is String
            ? int.tryParse(json['copies']) ?? 0
            : (json['copies'] is int ? json['copies'] : 0),
        isRented: json['isRented'] as bool? ?? false,
      );
  tojson() => {
        'id': id,
        'title': title,
        'author': author,
        'genre': genre,
        'copies': copies,
        'isRented': isRented
      };

  factory BookModel.fromMap(Map<String, dynamic> map, String documentId) {
    return BookModel(
      genre: map['genre'] ?? '',
      id: documentId,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      copies: map['copies'] is String
          ? int.tryParse(map['copies']) ?? 0
          : (map['copies'] is int ? map['copies'] : 0),
      isRented: map['isRented'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'copies': copies,
      'isRented': isRented,
    };
  }
}
