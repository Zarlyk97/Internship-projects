import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_project/features/rental_management/domain/repositories/rental_repository.dart';

class RentedRepositoryImpl implements RentalRepository {
  final FirebaseFirestore firestore;

  RentedRepositoryImpl({required this.firestore});
  @override
  Future<void> addRentedBook(String bookId, String userId) async {
    try {
      final bookDoc = await firestore.collection('books').doc(bookId).get();
      if (!bookDoc.exists) {
        throw Exception('Book not found');
      }

      // Колдонуучунун арендадагы китептерин текшерүү
      final rentedBooksRef = firestore
          .collection('users')
          .doc(userId)
          .collection('rented_Books')
          .where('book_id', isEqualTo: bookId);

      final rentedBooksSnapshot = await rentedBooksRef.get();
      if (rentedBooksSnapshot.docs.isNotEmpty) {
        throw Exception('Book is already rented by this user.');
      }

      await firestore
          .collection('users')
          .doc(userId)
          .collection('rented_Books')
          .add({
        'book_id': bookId,
        'rented_date': Timestamp.now(),
        'return_date':
            Timestamp.fromDate(DateTime.now().add(const Duration(days: 7))),
        'status': 'active',
        'isRented': true,
      });
    } catch (e) {
      throw Exception('Failed to add rented book: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchRentedBooks(String userId) async {
    try {
      final rentedBooksRef =
          firestore.collection('users').doc(userId).collection('rented_Books');

      final rentedBooksSnapshot = await rentedBooksRef.get();
      List<Map<String, dynamic>> rentedBooks = [];

      if (rentedBooksSnapshot.docs.isNotEmpty) {
        for (var doc in rentedBooksSnapshot.docs) {
          rentedBooks.add({
            'book_id': doc['book_id'],
            'rented_date': doc['rented_date'],
            'return_date': doc['return_date'],
            'status': doc['status'],
            'isRented': doc['isRented'],
          });
        }
      }

      return rentedBooks; // Арендага алынган китептер
    } catch (e) {
      throw Exception('Failed to fetch rented books: $e');
    }
  }
}
