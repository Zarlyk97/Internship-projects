import 'package:library_project/features/library_management/domain/entities/book_model.dart';

abstract class BookRepository {
  Future<List<Book>> searchBook(String query);
  Future<Book> getBookById(String id);
  Future<void> updateBook(Book book);
}
