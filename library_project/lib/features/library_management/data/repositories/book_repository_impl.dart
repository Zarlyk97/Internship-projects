import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_project/features/library_management/data/models/book_model.dart';
import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final FirebaseFirestore firestore;

  BookRepositoryImpl({required this.firestore});

  @override
  Future<List<BookModel>> fetchBooks() async {
    final snapshot = await firestore.collection('books').get();
    return snapshot.docs
        .map((doc) => BookModel.fromJson(doc.data()..['id'] = doc.id, doc.id))
        .toList();
  }

  @override
  Future<void> rentBook(String bookById, String userId, int copies) async {
    if (bookById.isEmpty || userId.isEmpty) {
      throw ArgumentError('Book ID and User ID must not be empty.');
    }
    final bookRef = firestore.collection('books').doc(bookById);
    final userRef = firestore.collection('users').doc(userId);

    await bookRef.update({
      'isRented': true,
      'userId': userId,
    });
    final List<String> listBook = [];

    listBook.add(bookById);
    listBook.add(copies.toString());
    // Колдонуучунун арендалаган китептерине кошуу
    await userRef.update({
      'bookList': listBook,
    });
    print('Book rented successfully.');
  }

  Future<BookModel?> getUserById(String id) async {
    try {
      DocumentSnapshot doc = await firestore.collection('books').doc(id).get();
      if (doc.exists) {
        return BookModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        print('Document with id $id not found');
        return null;
      }
    } catch (e) {
      print('Error getting document: $e');
      return null;
    }
  }
}
