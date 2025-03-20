import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devilfruitdex/domain/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firebasestore})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw Exception('User not found');
      } else if (e.code == 'wrong-password') {
        throw Exception('Incorrect password');
      } else {
        throw Exception('Login failed: ${e.message}');
      }
    }
  }

  @override
  Future<UserCredential> create(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('The email is already in use');
      } else if (e.code == 'weak-password') {
        throw Exception('Weak password');
      } else {
        throw Exception('Login failed: ${e.message}');
      }
    }
  }

  @override
  Future<User?> userLoaded() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<String?> getEmail() async {
    try {
      String? email = FirebaseAuth.instance.currentUser?.email;
      return email;
    } catch (e) {
      throw Exception('Email not found');
    }
  }

  @override
  Future<void> reauthenticateWithPassword(String currentPassword) async {
    User? user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in.');
    }

    try {
      String email = user.email!;

      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: currentPassword);

      await user.reauthenticateWithCredential(credential);
      
    } catch (e) {
      throw Exception('Failed to reauthenticate: ${e.toString()}');
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    User? user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in.');
    }

    try {
      await user.updatePassword(newPassword);
    } catch (e) {
      throw Exception('Failed to update password: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
