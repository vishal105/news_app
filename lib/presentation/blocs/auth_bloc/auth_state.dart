part of 'auth_bloc.dart';

/// Abstract class representing authentication states.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Initial state of authentication.
class AuthInitial extends AuthState {}

/// Loading state of authentication.
class AuthLoading extends AuthState {}

/// Authenticated state.
class Authenticated extends AuthState {
  final User user;

  Authenticated({required this.user});

  @override
  List<Object> get props => [user];
}

/// Unauthenticated state.
class Unauthenticated extends AuthState {}

/// Error state of authentication.
class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object> get props => [message];
}
