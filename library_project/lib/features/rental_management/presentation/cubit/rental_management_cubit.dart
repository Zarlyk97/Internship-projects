import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/book_management/data/models/book_model.dart';
import 'package:library_project/features/book_management/domain/usecases/fetch_books_usecase.dart';
import 'package:library_project/features/book_management/presentation/cubit/book_cubit.dart';
import 'package:library_project/features/rental_management/domain/usecases/get_rentedbook_usecase.dart';

part 'rental_management_state.dart';

class RentalManagementCubit extends Cubit<RentalManagementState> {
  final BookCubit bookCubit; // BookCubit колдонуу
  final FetchBookUsecase fetchBooksUseCase;
  final GetRentedbookUsecase getRentedbookUsecase;
  RentalManagementCubit(
      this.bookCubit, this.fetchBooksUseCase, this.getRentedbookUsecase)
      : super(RentalManagementInitial());

  Future<void> fetchRentedBooks(String userId) async {
    emit(RentalManagementLoading());
    try {
      final rentedBooks = await getRentedbookUsecase.getUserRentedBooks(userId);
      emit(RentalManagementSuccess(books: rentedBooks));
    } catch (e) {
      emit(RentalManagementFailure(errormessage: e.toString()));
    }
  }

  Future<void> returnBook(String bookId, String userId) async {
    emit(RentalManagementLoading());
    try {
      final rentedBookRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('rented_Books')
          .where('book_id', isEqualTo: bookId);

      final rentedBookSnapshot = await rentedBookRef.get(); // Документти алуу

      if (rentedBookSnapshot.docs.isEmpty) {
        throw Exception('This book is not rented by the user');
      }

      // Китепти табуу жана аны жоюу
      for (var doc in rentedBookSnapshot.docs) {
        await doc.reference.delete();
      }

      final bookRef =
          FirebaseFirestore.instance.collection('books').doc(bookId);

      await bookRef.update({
        'copies': FieldValue.increment(1),
        'isRented': false, // Китепти жеткиликтүү кылуу
      });

      await fetchRentedBooks(userId);
    } catch (e) {
      emit(RentalManagementFailure(errormessage: e.toString()));
    }
  }
}
