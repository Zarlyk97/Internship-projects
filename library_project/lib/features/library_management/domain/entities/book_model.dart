class Book {
  Book({
    this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.copies,
    this.isRented = false,
  });

  final String? id;
  final String title;
  final String author;
  final String genre;
  final int copies;
  final bool isRented;
}
