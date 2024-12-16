import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_project/features/library_management/domain/usecases/fetch_books_usecase.dart';
import 'package:library_project/features/library_management/presentation/cubit/book_state.dart';

class BookCubit extends Cubit<BookState> {
  final FetchBookUsecase fetchBooksUseCase;
  BookCubit(this.fetchBooksUseCase, super.initialState);

  Future<void> loadBooks() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final books = await fetchBooksUseCase();
      emit(state.copyWith(books: books, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
