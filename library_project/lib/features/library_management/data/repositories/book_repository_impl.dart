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
        .map((doc) => BookModel.fromJson(doc.data()..['id'] = doc))
        .toList();
  }

  @override
  Future<void> rentBook(String bookId) async {
    final docRef = firestore.collection('books').doc(bookId);
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      final copies = data['copies'] ?? 0;
      if (copies > 0) {
        await docRef.update({'copies': copies - 1});
      } else {
        throw Exception('Book not found');
      }
    }
  }
}
