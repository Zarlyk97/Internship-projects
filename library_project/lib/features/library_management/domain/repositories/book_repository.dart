import 'package:library_project/features/library_management/data/models/book_model.dart';
import 'package:library_project/features/library_management/domain/entities/book_model.dart';

abstract class BookRepository {
  Future<List<Book>> fetchBooks();
  // Future<void> rentedBook(Book book, String bookId, int copies);
  Future<BookModel> getBookById(String bookId);
  Future<void> updatBook(BookModel book);
}
