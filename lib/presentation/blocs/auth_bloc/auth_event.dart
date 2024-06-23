part of 'auth_bloc.dart';

/// Abstract class representing authentication events.
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Event to check authentication status.
class CheckAuthEvent extends AuthEvent {}

/// Event to sign in with email and password.
class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

/// Event to sign out.
class SignOutEvent extends AuthEvent {}
