import 'package:library_project/features/book_management/data/models/book_model.dart';
import 'package:library_project/features/book_management/domain/repositories/book_repository.dart';

class FetchBookUsecase {
  final BookRepository _bookRepository;

  FetchBookUsecase(this._bookRepository);

  Future<List<BookModel>> call() async {
    return await _bookRepository.fetchBooks();
  }
}
