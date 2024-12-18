import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/library_management/domain/usecases/fetch_books_usecase.dart';
import 'package:library_project/features/library_management/domain/usecases/rent_book_usecase.dart';
import 'package:library_project/features/library_management/presentation/cubit/book_state.dart';

class BookCubit extends Cubit<BookState> {
  final RentBookUsecase rentBookUseCase;
  final FetchBookUsecase fetchBooksUseCase;
  BookCubit(this.rentBookUseCase, this.fetchBooksUseCase)
      : super(BookStateInitial());

  Future<void> fetchBooks() async {
    emit(BookStateLoading());
    try {
      final books = await fetchBooksUseCase();
      emit(BookStateLoaded(books: books));
    } catch (e) {
      emit(BookStateFailure());
    }
  }

  Future<void> rentBook(String bookId, String userId) async {
    try {
      emit(BookStateLoading());
      await rentBookUseCase(bookId, userId);
      emit(BookStateLoaded(books: []));
      await fetchBooks();
    } catch (e) {
      emit(BookStateFailure());
    }
  }
}
