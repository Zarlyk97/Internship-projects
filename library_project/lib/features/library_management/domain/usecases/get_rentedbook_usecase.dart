import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_project/features/library_management/data/models/book_model.dart';
import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';

class GetRentedbookUsecase {
  final BookRepository bookRepository;

  GetRentedbookUsecase(this.bookRepository);
  Future<List<BookModel>> getUserRentedBooks(String userId) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    // User документин ал
    final userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      final userData = userSnapshot.data()!;

      // bookList массивинен ID'лерди алуу
      List<String> bookIds = List<String>.from(userData['bookList'] ?? []);

      // ID'лер боюнча китептерди алып келүү
      final books = <BookModel>[];
      for (String bookId in bookIds) {
        final bookSnapshot = await FirebaseFirestore.instance
            .collection('books')
            .doc(bookId)
            .get();

        if (bookSnapshot.exists) {
          books.add(BookModel.fromMap(bookSnapshot.data()!, bookSnapshot.id));
        }
      }
      return books;
    } else {
      throw Exception('User not found');
    }
  }
}
