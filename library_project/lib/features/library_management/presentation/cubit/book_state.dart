import 'package:library_project/features/library_management/domain/entities/book_model.dart';

class BookState {
  final List<Book> books;
  final bool isLoading;
  final String error;

  BookState(
    this.books,
    this.isLoading,
    this.error,
  );

  BookState copyWith({
    List<Book>? books,
    bool? isLoading,
    String? error,
  }) {
    return BookState(
      books ?? this.books,
      isLoading ?? this.isLoading,
      error ?? this.error,
    );
  }
}
