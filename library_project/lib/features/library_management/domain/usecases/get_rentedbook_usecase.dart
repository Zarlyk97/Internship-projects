import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_project/features/library_management/data/models/book_model.dart';
import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';

class GetRentedbookUsecase {
  final BookRepository bookRepository;

  GetRentedbookUsecase(this.bookRepository);
  Future<List<BookModel>> getUserRentedBooks(String userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    // User документин ал
    if (userDoc.exists) {
      throw Exception('User not found');
    }

    // bookList массивинен ID'лерди алуу
    List<String> bookIds = List<String>.from(userDoc.data()?['bookList'] ?? []);
    if (bookIds.isEmpty) {
      return [];
    }

    // ID'лер боюнча китептерди алып келүү
    final books = <BookModel>[];
    for (var bookId in bookIds) {
      final bookSnapshot = await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .get();

      if (bookSnapshot.exists) {
        books.add(BookModel.fromMap(bookSnapshot.data()!, bookSnapshot.id));
      }
    }
    return books;
  }
}
