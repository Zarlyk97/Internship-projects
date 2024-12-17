import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/library_management/domain/usecases/fetch_books_usecase.dart';
import 'package:library_project/features/library_management/presentation/cubit/book_state.dart';

class BookCubit extends Cubit<BookState> {
  // final FirebaseFirestore _firebaseFirestore;
  final FetchBookUsecase fetchBooksUseCase;
  BookCubit(this.fetchBooksUseCase) : super(BookStateInitial());

  Future<void> loadBooks() async {
    emit(BookStateLoading());
    try {
      final books = await fetchBooksUseCase();
      emit(BookStateLoaded(books: books));
    } catch (e) {
      emit(BookStateFailure());
    }
  }

//   Future<void> rentBook(String bookId, String userId) async {
//     try {
// ///////////
//       await _firebaseFirestore
//           .collection('books')
//           .doc(bookId)
//           .update({'isRented': true, 'rentedBy': userId});

//       //////////
//       await _firebaseFirestore.collection('users').doc(userId).update({
//         'rentedBooks': FieldValue.arrayUnion([bookId])
//       });
//       emit(BookStateRented());
//     } catch (e) {
//       emit(BookStateFailure());
//     }
//   }
}
