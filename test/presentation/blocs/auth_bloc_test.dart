import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/domain/usecases/auth_usecases.dart';
import 'package:news_app/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../mock_classes.mocks.dart';

void main() {
  late AuthBloc bloc;
  late MockSignInUseCase mockSignInUseCase;
  late MockSignOutUseCase mockSignOutUseCase;
  late MockUser mockUser;

  setUp(() {
    mockSignInUseCase = MockSignInUseCase();
    mockSignOutUseCase = MockSignOutUseCase();
    mockUser = MockUser();
    bloc = AuthBloc(
      signInUseCase: mockSignInUseCase,
      signOutUseCase: mockSignOutUseCase,
    );
  });

  final email = 'test@test.com';
  final password = 'password';

  test('initial state should be AuthInitial', () {
    expect(bloc.state, AuthInitial());
  });

  blocTest<AuthBloc, AuthState>(
    'should emit [AuthLoading, Authenticated] when sign in is successful',
    build: () {
      when(mockSignInUseCase(email, password))
          .thenAnswer((_) async => Future.value(mockUser));
      return bloc;
    },
    act: (bloc) => bloc.add(SignInEvent(email: email, password: password)),
    expect: () => [
      AuthLoading(),
      Authenticated(user: mockUser),
    ],
    verify: (bloc) {
      verify(mockSignInUseCase(email, password));
    },
  );

  blocTest<AuthBloc, AuthState>(
    'should emit [AuthLoading, AuthError] when sign in is unsuccessful',
    build: () {
      when(mockSignInUseCase(email, password))
          .thenThrow(Exception('Sign in failed'));
      return bloc;
    },
    act: (bloc) => bloc.add(SignInEvent(email: email, password: password)),
    expect: () => [
      AuthLoading(),
      AuthError(message: 'Exception: Sign in failed'),
    ],
    verify: (bloc) {
      verify(mockSignInUseCase(email, password));
    },
  );

  blocTest<AuthBloc, AuthState>(
    'should emit [AuthLoading, Unauthenticated] when sign out is successful',
    build: () {
      when(mockSignOutUseCase())
          .thenAnswer((_) async => Future.value(null));
      return bloc;
    },
    act: (bloc) => bloc.add(SignOutEvent()),
    expect: () => [
      AuthLoading(),
      Unauthenticated(),
    ],
    verify: (bloc) {
      verify(mockSignOutUseCase());
    },
  );
}
