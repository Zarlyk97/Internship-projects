import 'package:library_project/features/auth/domain/entities/user_entity.dart';

class Member extends UserEntity {
  Member({
    required super.id,
    required super.email,
    super.userName,
  });
}
