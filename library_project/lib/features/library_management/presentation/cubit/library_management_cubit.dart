import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'library_management_state.dart';

class LibraryManagementCubit extends Cubit<LibraryManagementState> {
  LibraryManagementCubit() : super(LibraryManagementInitial());
}
