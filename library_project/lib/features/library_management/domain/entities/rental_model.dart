class Rental {
  Rental(
      {required String bookId,
      required String userId,
      required this.rentalDate,
      required this.returnDate})
      : _bookId = bookId,
        _userId = userId;

  String get bookId => _bookId;
  String get userId => _userId;

  set userId(String userId) => _userId = userId;
  set bookId(String bookId) => _bookId = bookId;

  String _bookId;
  String _userId;
  final DateTime rentalDate;
  final DateTime returnDate;
}
