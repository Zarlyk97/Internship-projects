// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:library_project/features/auth/domain/entities/user_entinty.dart';
import 'package:library_project/features/auth/domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final firebase_auth.FirebaseAuth firebaseAuth;

  FirebaseAuthRepository({
    required this.firebaseAuth,
  });
  @override
  Future<User> login(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return User(id: credential.user!.uid, email: credential.user!.email!);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password) async {
    try {
      final credetial = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseFirestore.instance
          .collection('users')
          .doc(credetial.user!.uid)
          .set({'email': email, 'bookList': []});
      return User(id: credetial.user!.uid, email: credetial.user!.email!);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
