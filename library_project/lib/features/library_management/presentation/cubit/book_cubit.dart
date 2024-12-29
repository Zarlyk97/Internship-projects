import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/library_management/data/models/book_model.dart';
import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';
import 'package:library_project/features/library_management/domain/usecases/fetch_books_usecase.dart';
import 'package:library_project/features/library_management/domain/usecases/get_rentedbook_usecase.dart';
import 'package:library_project/features/library_management/domain/usecases/rent_book_usecase.dart';
import 'package:library_project/features/library_management/presentation/cubit/book_state.dart';

class BookCubit extends Cubit<BookState> {
  final BookRepository bookRepository;
  final RentBookUsecase rentBookUseCase;
  final FetchBookUsecase fetchBooksUseCase;
  final GetRentedbookUsecase getRentedbookUsecase;

  BookCubit(
    this.rentBookUseCase,
    this.fetchBooksUseCase,
    this.bookRepository,
    this.getRentedbookUsecase,
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
      await fetchBooks();
    } catch (e) {
      emit(BookStateFailure(errormessage: e.toString()));
    }
  }

  Future<void> fetchRentedBooks(String userId) async {
    emit(BookStateLoading());
    try {
      final rentedBooks = await getRentedbookUsecase.getUserRentedBooks(userId);
      emit(BookStateLoaded(books: rentedBooks));
    } catch (e) {
      emit(BookStateFailure(errormessage: e.toString()));
    }
  }
}
