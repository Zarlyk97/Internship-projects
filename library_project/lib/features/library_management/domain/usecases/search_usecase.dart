import 'package:library_project/features/library_management/domain/entities/book_model.dart';
import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';

class SearchBook {
  final BookRepository _bookRepository;

  SearchBook(this._bookRepository);

  Future<List<Book>> call(String query) {
    return _bookRepository.searchBook(query);
  }
}
