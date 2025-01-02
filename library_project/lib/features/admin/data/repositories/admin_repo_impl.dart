import 'package:library_project/features/admin/data/datasources/admin_remote_data_source.dart';
import 'package:library_project/features/admin/domain/repositories/admin_repo.dart';
import 'package:library_project/features/auth/domain/entities/admin_entity.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource adminRemoteDataSource;

  AdminRepositoryImpl({required this.adminRemoteDataSource});
  @override
  Future<void> addBooks(AdminEntity books) {
    return adminRemoteDataSource.addBooks(books);
  }
}
