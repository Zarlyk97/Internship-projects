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
        .map((doc) => BookModel.fromMap({...doc.data(), 'id': doc.id}, doc.id))
        .toList();
  }

  @override
  Future<BookModel> getBookById(String bookId) async {
    try {
      final doc = await firestore.collection('books').doc(bookId).get();
      if (doc.exists) {
        return BookModel.fromMap(doc.data()!, doc.id);
      } else {
        throw Exception('Book not found');
      }
    } catch (e) {
      throw Exception('Failed to get book: $e');
    }
  }

  @override
  Future<void> updateBook(BookModel book) async {
    try {
      await firestore.collection('books').doc(book.id).update(book.toMap());
    } catch (e) {
      throw Exception('Failed to update book: $e');
    }
  }

  @override
  Future<void> addRentedBook(String bookId, String userId) async {
    try {
      final bookDoc = await firestore.collection('books').doc(bookId).get();
      if (!bookDoc.exists) {
        throw Exception('Book not found');
      }
      await firestore
          .collection('users')
          .doc(userId)
          .collection('rented_Books')
          .add({
        'book_id': bookId,
        'rented_date': Timestamp.now(),
        'return_date': null, // Китеп кайтарылбаган учурда
        'status': 'active', // Китеп активдүү арендада
      });
    } catch (e) {
      throw Exception('Failed to add rented book: $e');
    }
  }

  Future<List<BookModel>> fetchRentedBooks(String userId) async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('rented_Books')
        .get();
    return snapshot.docs.map((doc) {
      final bookData = doc.data();
      return BookModel(
        id: bookData['book_id'],
        title: bookData['title'] ?? 'Unknown Title',
        author: bookData['author'] ?? 'Unknown Author',
        genre: bookData['genre'],
        copies: bookData['copies'],
        isRented: bookData['isRented'],
      );
    }).toList();
  }
}
