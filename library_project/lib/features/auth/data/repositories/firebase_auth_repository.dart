// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:library_project/features/auth/domain/entities/user_entity.dart';
import 'package:library_project/features/auth/domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  FirebaseAuthRepository({
    required this.firebaseAuth,
    required this.firestore,
  });
  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserEntity(
        id: credential.user!.uid,
        email: credential.user!.email!,
      );
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<UserEntity> register(
      String email, String password, String userName) async {
    try {
      final credetial = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseFirestore.instance
          .collection('users')
          .doc(credetial.user!.uid)
          .set({
        'email': email,
        'userName': userName,
        'createdAt': Timestamp.now()
      });
      return UserEntity(
        id: credetial.user!.uid,
        email: credetial.user!.email!,
      );
    } catch (e) {
      if (e is firebase_auth.FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          alert('Email already in use');
        }
      }
      throw Exception();
    }
  }

  void alert(String s) {}
}
