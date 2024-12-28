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
          .collection('rented_books')
          .get();

      ////////////////////////////////   аренда болгон китептерди алуу
      if (rentedBooksSnapshot.docs.isEmpty) {
        return []; ///////////////////Китеп жок болсо бош тизме кайтаруу
      }

      final books = <BookModel>[];
      for (var rentedBookDoc in rentedBooksSnapshot.docs) {
        final bookId = rentedBookDoc['book_id'];
        final bookSnapshot = await FirebaseFirestore.instance
            .collection('books')
            .doc(bookId)
            .get();

        if (bookSnapshot.exists) {
          books.add(BookModel.fromMap(bookSnapshot.data()!, bookSnapshot.id));
        }
      }

      return books;
    } catch (e) {
      throw Exception('Failed to get rented books: $e');
    }
  }
}
