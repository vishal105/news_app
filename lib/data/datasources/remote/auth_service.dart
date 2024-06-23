import 'package:firebase_auth/firebase_auth.dart';

/// Abstract class representing the authentication service.
abstract class AuthService {
  Future<User?> signIn(String email, String password);
  Future<void> signOut();
}

/// Implementation of AuthService using Firebase Authentication.
class AuthServiceImpl implements AuthService {
  final FirebaseAuth firebaseAuth;

  AuthServiceImpl(this.firebaseAuth);

  @override
  Future<User?> signIn(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
