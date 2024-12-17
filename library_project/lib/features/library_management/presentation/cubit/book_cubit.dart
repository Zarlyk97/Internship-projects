import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/library_management/domain/usecases/fetch_books_usecase.dart';
import 'package:library_project/features/library_management/presentation/cubit/book_state.dart';

class BookCubit extends Cubit<BookState> {
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
}
