import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/library_management/data/models/book_model.dart';
import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';
import 'package:library_project/features/library_management/domain/usecases/fetch_books_usecase.dart';
import 'package:library_project/features/library_management/domain/usecases/rent_book_usecase.dart';
import 'package:library_project/features/library_management/presentation/cubit/book_state.dart';

class BookCubit extends Cubit<BookState> {
  final BookRepository bookRepository;
  final List<BookModel> books = [];
  final RentBookUsecase rentBookUseCase;
  final FetchBookUsecase fetchBooksUseCase;
  BookCubit(this.rentBookUseCase, this.fetchBooksUseCase, this.bookRepository)
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

  Future<void> rentBook(String bookId) async {
    emit(BookStateLoading());
    try {
      await rentBookUseCase.execute(bookId);
      emit(BookStateLoaded(books: books));
    } catch (e) {
      emit(BookStateFailure());
    }
  }
}
