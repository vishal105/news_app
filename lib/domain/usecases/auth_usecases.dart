import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/domain/repositories/auth_repository.dart';

/// Use case for signing in.
class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<User?> call(String email, String password) async {
    return await repository.signIn(email, password);
  }
}

/// Use case for signing out.
class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() async {
    return await repository.signOut();
  }
}
