class Rental {
  Rental(
      {required this.bookId,
      required this.userId,
      required this.rentalDate,
      required this.returnDate});

  final String bookId;
  final String userId;
  final DateTime rentalDate;
  final DateTime returnDate;
}
