import 'package:library_project/features/book_management/data/models/book_model.dart';

abstract final class BookState {}

final class BookStateInitial extends BookState {}

final class BookStateLoaded extends BookState {
  final List<BookModel> books;

  BookStateLoaded({required this.books});
}

final class BookStateLoading extends BookState {}

final class BookStateFailure extends BookState {
  final String errormessage;

  BookStateFailure({required this.errormessage});
}

final class BookStateRented extends BookState {}
