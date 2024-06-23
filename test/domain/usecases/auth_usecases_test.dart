import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/domain/repositories/auth_repository.dart';
import 'package:news_app/domain/usecases/auth_usecases.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../mock_classes.mocks.dart';

void main() {
  late SignInUseCase signInUseCase;
  late SignOutUseCase signOutUseCase;
  late MockAuthRepository mockAuthRepository;
  late MockUser mockUser;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInUseCase = SignInUseCase(mockAuthRepository);
    signOutUseCase = SignOutUseCase(mockAuthRepository);
    mockUser = MockUser();
  });

  final email = 'test@test.com';
  final password = 'password';

  test('should sign in the user using the repository', () async {
    // arrange
    when(mockAuthRepository.signIn(email, password))
        .thenAnswer((_) async => Future.value(mockUser));

    // act
    final result = await signInUseCase(email, password);

    // assert
    expect(result, mockUser);
    verify(mockAuthRepository.signIn(email, password));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should sign out the user using the repository', () async {
    // arrange
    when(mockAuthRepository.signOut()).thenAnswer((_) async => Future.value(null));

    // act
    await signOutUseCase();

    // assert
    verify(mockAuthRepository.signOut());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
