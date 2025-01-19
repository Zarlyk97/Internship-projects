import 'package:library_project/features/book_management/data/models/book_model.dart';

abstract interface class BookRepository {
  Future<List<BookModel>> fetchBooks();
  Future<BookModel> getBookById(String bookId);
  Future<void> updateBook(BookModel book);
}
