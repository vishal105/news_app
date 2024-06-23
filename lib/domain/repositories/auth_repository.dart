import 'package:firebase_auth/firebase_auth.dart';

/// Abstract class representing the authentication repository.
abstract class AuthRepository {
  Future<User?> signIn(String email, String password);
  Future<void> signOut();
}
