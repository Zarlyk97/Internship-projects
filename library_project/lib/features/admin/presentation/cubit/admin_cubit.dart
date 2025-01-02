import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_project/features/admin/domain/repositories/admin_repo.dart';
import 'package:library_project/features/auth/domain/entities/admin_entity.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepository adminRepository;
  AdminCubit(this.adminRepository) : super(AdminInitial());

  Future<void> addBooks(AdminEntity books) async {
    emit(AdminLoading());
    try {
      await adminRepository.addBooks(books);
      emit(AdminLoaded());
    } catch (e) {
      emit(AdminFailure());
    }
  }
}
