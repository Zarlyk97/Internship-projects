import 'package:library_project/features/library_management/domain/entities/book_model.dart';

abstract class BookRepository {
  Future<List<Book>> fetchBooks();
  Future<void> rentBook(String bookById);
}
