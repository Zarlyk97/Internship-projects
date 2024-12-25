class Book {
  Book({
    this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.copies,
    this.isRented = true,
  });

  final String? id;
  final String title;
  final String author;
  final String genre;
  int copies;
  bool isRented;
}
