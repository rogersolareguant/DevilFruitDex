import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<UserCredential> login(String email, String password);

  Future<UserCredential> create(String email, String password);

  Future<User?> userLoaded();

  Future<String?> getEmail();

  Future<void> signOut();
}
