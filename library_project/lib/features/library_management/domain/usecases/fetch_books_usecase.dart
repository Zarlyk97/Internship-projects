import 'package:library_project/features/library_management/domain/entities/book_model.dart';
import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';

class FetchBookUsecase {
  final BookRepository _bookRepository;

  FetchBookUsecase(this._bookRepository);

  Future<List<Book>> call() async {
    return await _bookRepository.fetchBooks();
  }
}
