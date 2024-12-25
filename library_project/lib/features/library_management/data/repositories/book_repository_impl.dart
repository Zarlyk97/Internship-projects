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
  Future<BookModel> getBookById(String bookId) async {
    try {
      final doc = await firestore.collection('books').doc(bookId).get();
      if (doc.exists) {
        return BookModel.fromJson(doc.data()!, doc.id);
      } else {
        throw Exception('Book not found');
      }
    } catch (e) {
      return throw Exception('Failed to fetch book: $e');
    }
  }

  @override
  Future<void> updatBook(BookModel book) async {
    try {
      await firestore.collection('books').doc(book.id).update(book.tojson());
    } catch (e) {
      throw Exception('Failed to update book: $e');
    }
  }
}
