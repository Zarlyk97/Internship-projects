import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/book_management/data/models/book_model.dart';
import 'package:library_project/features/book_management/domain/repositories/book_repository.dart';

import 'package:library_project/features/book_management/presentation/cubit/book_state.dart';
import 'package:library_project/features/rental_management/domain/usecases/rent_book_usecase.dart';

class BookCubit extends Cubit<BookState> {
  final RentBookUsecase rentBookUseCase;

  final BookRepository bookRepository;

  BookCubit(
    this.rentBookUseCase,
    this.bookRepository,
  ) : super(BookStateInitial());

  final List<BookModel> books = [];

  Future<void> fetchBooks() async {
    emit(BookStateLoading());
    try {
      final bookS = await bookRepository.fetchBooks();
      emit(BookStateLoaded(books: bookS));
    } catch (e) {
      emit(BookStateFailure(errormessage: e.toString()));
    }
  }

  Future<void> rentBook(String bookId, String userId) async {
    emit(BookStateLoading());
    try {
      await rentBookUseCase.execute(bookId, userId);
      final bookRef =
          FirebaseFirestore.instance.collection('books').doc(bookId);
      await bookRef.update({'isRented': true}); // Китеп арендада

      await fetchBooks();
    } catch (e) {
      emit(BookStateFailure(errormessage: e.toString()));
    }
  }
}
