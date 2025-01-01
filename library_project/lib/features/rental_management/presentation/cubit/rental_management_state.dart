part of 'rental_management_cubit.dart';

abstract class RentalManagementState extends Equatable {
  const RentalManagementState();

  @override
  List<Object> get props => [];
}

class RentalManagementInitial extends RentalManagementState {}

class RentalManagementLoading extends RentalManagementState {}

class RentalManagementSuccess extends RentalManagementState {
  final List<BookModel> books;
  const RentalManagementSuccess({required this.books});
}

class RentalManagementFailure extends RentalManagementState {
  final String errormessage;
  const RentalManagementFailure({required this.errormessage});
}
