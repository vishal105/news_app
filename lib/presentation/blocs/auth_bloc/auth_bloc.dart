import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/domain/usecases/auth_usecases.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/services/firebase_analytics_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// BLoC to handle authentication events and states.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final FirebaseAnalyticsService? analyticsService;

  AuthBloc({
    required this.signInUseCase,
    required this.signOutUseCase,
    this.analyticsService,
  }) : super(AuthInitial()) {
    on<CheckAuthEvent>((event, emit) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    });

    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signInUseCase(event.email, event.password);
        await analyticsService?.setUserId(user!.uid);
        await analyticsService?.logEvent('login', null);
        emit(Authenticated(user: user!));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<SignOutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signOutUseCase();
        await analyticsService?.logEvent('logout', null);
        emit(Unauthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
