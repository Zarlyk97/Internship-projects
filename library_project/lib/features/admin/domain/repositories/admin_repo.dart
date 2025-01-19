import 'package:library_project/features/auth/domain/entities/admin_entity.dart';

abstract interface class AdminRepository {
  Future<void> addBooks(AdminEntity admin);
}
