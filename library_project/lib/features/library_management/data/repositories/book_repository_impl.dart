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
  Future<void> rentBook(String bookById, String userId) async {
    final bookRef = firestore.collection('books').doc(bookById);
    final userRef = firestore.collection('users').doc(userId);

    ////////////// Update book status to "rented" //////////////
    await bookRef.update({
      'isRented': true,
      'userId': userId,
    });
    // Колдонуучунун арендалаган китептерине кошуу
    await userRef.update({
      'RenredBooks': FieldValue.arrayUnion([bookById]),
    });
  }
}
