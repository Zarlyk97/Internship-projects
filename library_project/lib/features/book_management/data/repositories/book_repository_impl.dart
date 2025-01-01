import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_project/features/book_management/data/models/book_model.dart';
import 'package:library_project/features/book_management/domain/repositories/book_repository.dart';

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
      await firestore.collection('books').doc(book.id).update({
        'title': book.title,
        'author': book.author,
        'copies': book.copies,
        'isRented': book.isRented,
        'genre': book.genre,
      });
    } catch (e) {
      throw Exception('Failed to update book: $e');
    }
  }
}
