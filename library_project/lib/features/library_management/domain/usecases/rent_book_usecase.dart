import 'package:library_project/features/library_management/domain/repositories/book_repository.dart';

class RentBookUsecase {
  final BookRepository _bookRepository;

  RentBookUsecase(this._bookRepository);

  Future<void> execute(String bookId, String userId) async {
    final book = await _bookRepository.getBookById(bookId);

    if (book.copies > 0) {
      book.copies -= 1;
      book.isRented = book.copies == 0;

      // Арендага алынган китепти сактоо
      await _bookRepository.addRentedBook(
        bookId,
        userId,
      );
      await _bookRepository.updateBook(book);
    } else {
      throw Exception('No copies available');
    }
  }
}
