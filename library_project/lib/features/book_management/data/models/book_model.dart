import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_project/features/book_management/domain/entities/book_model.dart';

class BookModel extends Book {
  final Timestamp? rentedDate;
  final Timestamp? returnDate;
  final String status; // Статус

  BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.genre,
    required super.copies,
    required super.isRented,
    this.rentedDate,
    this.returnDate,
    required this.status,
  });

  // Firestore документинен BookModel түзүү
  factory BookModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return BookModel(
      id: data['id'],
      title: data['title'],
      author: data['author'],
      genre: data['genre'],
      copies: data['copies'] is String
          ? int.tryParse(data['copies']) ?? 0
          : (data['copies'] is int ? data['copies'] : 0),
      isRented: data['isRented'] as bool? ?? false,
      status: data['status'] ?? 'active',
      rentedDate: data['rented_date'] as Timestamp?,
      returnDate: data['return_date'] as Timestamp?,
    );
  }

  // Объектти JSON форматына айландыруу
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'genre': genre,
        'copies': copies,
        'isRented': isRented,
        'status': status,
        'rented_date': rentedDate,
        'return_date': returnDate,
      };

  // Map форматына айландыруу
  factory BookModel.fromMap(Map<String, dynamic> map, String documentId) {
    return BookModel(
      id: documentId,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      genre: map['genre'] ?? '',
      copies: map['copies'] is String
          ? int.tryParse(map['copies']) ?? 0
          : (map['copies'] is int ? map['copies'] : 0),
      isRented: map['isRented'] ?? false,
      status: map['status'] ?? 'active',
      rentedDate: map['rented_date'] as Timestamp?,
      returnDate: map['return_date'] as Timestamp?,
    );
  }

  // Map форматына айландыруу
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'copies': copies,
      'isRented': isRented,
      'status': status,
      'rented_date': rentedDate,
      'return_date': returnDate,
    };
  }
}
