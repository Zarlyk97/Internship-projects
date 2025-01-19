abstract interface class RentalRepository {
  Future<void> addRentedBook(String bookId, String userId);
  Future<List<Map<String, dynamic>>> fetchRentedBooks(String userId);
}
