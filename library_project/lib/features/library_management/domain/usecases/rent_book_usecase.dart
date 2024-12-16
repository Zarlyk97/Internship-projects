import 'package:library_project/features/library_management/domain/entities/book_model.dart';
import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';

class RentBook {
  final BookRepository _repository;

  RentBook(this._repository);
  Future<Book> call(String id) {
    return _repository.getBookById(id);
  }
}
