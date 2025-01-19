import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_project/features/auth/domain/entities/admin_entity.dart';

abstract interface class AdminRemoteDataSource {
  Future<void> addBooks(AdminEntity books);
}

class AdminRemoteDataSourceimpl extends AdminRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addBooks(AdminEntity books) async {
    try {
      await firestore.collection('books').add(books.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
