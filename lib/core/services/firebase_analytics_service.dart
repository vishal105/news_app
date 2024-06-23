import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

/// Service class to handle Firebase Analytics logging and event tracking.
class FirebaseAnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Returns a [FirebaseAnalyticsObserver] for navigation observer.
  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  /// Logs a custom event to Firebase Analytics.
  ///
  /// [name] is the name of the event.
  /// [parameters] is a map of additional parameters for the event.
  Future<void> logEvent(String name, Map<String, Object>? parameters) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  /// Sets the user ID to Firebase Analytics.
  ///
  /// [userId] is the unique identifier for the user.
  Future<void> setUserId(String userId) async {
    await _analytics.setUserId(id: userId);
  }

  /// Sets the current screen name for Firebase Analytics.
  ///
  /// [screenName] is the name of the screen being viewed.
  Future<void> setCurrentScreen(String screenName) async {
    await _analytics.setCurrentScreen(screenName: screenName);
  }
}
