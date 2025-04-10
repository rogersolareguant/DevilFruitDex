import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<UserCredential> login(String email, String password);

  Future<UserCredential> create(String email, String password);

  Future<User?> userLoaded();

  Future<String?> getEmail();

  Future<String> getUserName(String uid);

  Future<void> setUserName(String uid, String userName);

  Future<void> reauthenticateWithPassword(String currentPassword);

  Future<void> updateUserPassword(String newPassword);

  Future<void> signOut();
}
