import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';

class RentBookUsecase {
  final BookRepository _bookRepository;

  RentBookUsecase(this._bookRepository);

  Future<void> call(String bookById, String userId) async {
    return await _bookRepository.rentBook(bookById, userId);
  }
}
