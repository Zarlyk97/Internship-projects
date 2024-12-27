import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';

class RentBookUsecase {
  final BookRepository _bookRepository;

  RentBookUsecase(this._bookRepository);

  Future<void> execute(String bookId, String userId) async {
    // Book тизмесин алып келүү же башка логика
    final book = await _bookRepository.getBookById(bookId);
    if (book.copies > 0) {
      book.copies -= 1;
      book.isRented = book.copies == 0;

      await _bookRepository.updateBook(book);
      await _bookRepository.addRentedBook(bookId, userId);
    } else {
      throw Exception('No copies available');
    }
  }
}
