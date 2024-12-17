import 'package:library_project/features/library_management/domain/entities/book_model.dart';

abstract final class BookState {}

final class BookStateInitial extends BookState {}

final class BookStateLoaded extends BookState {
  final List<Book> books;

  BookStateLoaded({required this.books});
}

final class BookStateLoading extends BookState {}

final class BookStateFailure extends BookState {}
