import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:library_project/features/auth/domain/entities/user_entinty.dart';
import 'package:library_project/features/profile_management/domain/repositories/profile_repository.dart';

class GetUserRepository implements ProfileRepository {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  GetUserRepository({required this.firebaseAuth, required this.firestore});
  @override
  Future<User> getUserProfile() async {
    try {
      final firebase_auth.User? currentUser = firebaseAuth.currentUser;
      if (currentUser == null) throw Exception('No user logged in');

      final userDoc =
          await firestore.collection('users').doc(currentUser.uid).get();
      if (!userDoc.exists) {
        throw Exception('User not found');
      }
      final userData = userDoc.data()!;
      return User(
        id: currentUser.uid,
        email: userData['email'],
        userName: userData['userName'],
      );
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }
}
