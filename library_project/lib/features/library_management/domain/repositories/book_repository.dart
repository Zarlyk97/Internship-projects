import 'package:library_project/features/library_management/data/models/book_model.dart';

abstract class BookRepository {
  Future<List<BookModel>> fetchBooks();
  Future<BookModel> getBookById(String bookId);
  Future<void> updateBook(BookModel book);
  Future<void> addRentedBook(String bookId, String userId);
}
