import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/data/datasources/remote/auth_service.dart';
import 'package:news_app/domain/repositories/auth_repository.dart';

/// Implementation of AuthRepository.
class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({required this.authService});

  @override
  Future<User?> signIn(String email, String password) {
    return authService.signIn(email, password);
  }

  @override
  Future<void> signOut() {
    return authService.signOut();
  }
}
