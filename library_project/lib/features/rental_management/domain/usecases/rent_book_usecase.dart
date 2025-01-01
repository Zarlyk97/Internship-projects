import 'package:library_project/features/book_management/domain/repositories/book_repository.dart';
import 'package:library_project/features/rental_management/domain/repositories/rental_repository.dart';

class RentBookUsecase {
  final RentalRepository rentalRepository;
  final BookRepository bookRepository;

  RentBookUsecase(this.bookRepository, this.rentalRepository);

  Future<void> execute(String bookId, String userId) async {
    final book = await bookRepository.getBookById(bookId);

    if (book.copies > 0) {
      book.copies -= 1;
      book.isRented = book.copies == 0;

      // Арендага алынган китепти сактоо
      await rentalRepository.addRentedBook(
        bookId,
        userId,
      );
      await bookRepository.updateBook(book);
    } else {
      throw Exception('No copies available');
    }
  }
}
