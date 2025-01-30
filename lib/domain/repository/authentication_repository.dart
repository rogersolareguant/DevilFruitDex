import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<UserCredential> login(String email, String password);

  Future<UserCredential> create(String email, String password);

  Future<User?> userLoaded();
}
