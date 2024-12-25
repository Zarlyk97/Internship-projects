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
        copies:
            json['copies'] is String ? int.tryParse(json['copies']) ?? 1 : 5,
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
      copies: map['copies'] ?? 0,
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

// class Book {
//   final String id;
//   final String title;
//   final String author;
//   int copies;
//   bool isRented;

//   Book({
//     required this.id,
//     required this.title,
//     required this.author,
//     required this.copies,
//     required this.isRented,
//   });

//   factory Book.fromMap(Map<String, dynamic> map, String documentId) {
//     return Book(
//       id: documentId,
//       title: map['title'] ?? '',
//       author: map['author'] ?? '',
//       copies: map['copies'] ?? 0,
//       isRented: map['isRented'] ?? false,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'author': author,
//       'copies': copies,
//       'isRented': isRented,
//     };
//   }
// }
