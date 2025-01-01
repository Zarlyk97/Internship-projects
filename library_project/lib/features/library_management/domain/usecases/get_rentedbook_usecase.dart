import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_project/features/library_management/data/models/book_model.dart';
import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';

class GetRentedbookUsecase {
  final BookRepository bookRepository;

  GetRentedbookUsecase(this.bookRepository);

  Future<List<BookModel>> getUserRentedBooks(String userId) async {
    try {
      final rentedBooksSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('rented_Books')
          .get();

      if (rentedBooksSnapshot.docs.isEmpty) {
        return []; ///////
      }
      final bookIds =
          rentedBooksSnapshot.docs.map((doc) => doc['book_id']).toList();

      final booksSnapshot = await Future.wait(
        bookIds.map((bookId) =>
            FirebaseFirestore.instance.collection('books').doc(bookId).get()),
      );

      final books = booksSnapshot
          .where((snapshot) => snapshot.exists) // Бар болсо гана кошуңуз
          .map((snapshot) => BookModel.fromMap(snapshot.data()!, snapshot.id))
          .toList();

      return books;
    } catch (e) {
      throw Exception('Failed to get rented books: $e');
    }
  }
}
