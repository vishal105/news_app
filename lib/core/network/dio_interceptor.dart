import 'package:dio/dio.dart';
import 'package:news_app/core/services/firebase_analytics_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DioInterceptor extends Interceptor {
  final FirebaseAnalyticsService analyticsService;

  DioInterceptor(this.analyticsService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? 'unknown_user';

    options.headers['user-id'] = userId;

    // Add a timestamp to the request to measure the duration later
    options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;

    await analyticsService.logEvent('api_request', {
      'url': options.path,
      'method': options.method,
      'user_id': userId,
    });

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Calculate the duration of the request
    final startTime = response.requestOptions.extra['startTime'] as int?;
    final duration = DateTime.now().millisecondsSinceEpoch - (startTime ?? 0);
    final userId = response.requestOptions.headers['user-id'] ?? 'unknown_user';

    await analyticsService.logEvent('api_response', {
      'url': response.requestOptions.path,
      'method': response.requestOptions.method,
      'duration_ms': duration,
      'user_id': userId,
      'status_code': response.statusCode ?? 0,
    });

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Calculate the duration of the request
    final startTime = err.requestOptions.extra['startTime'] as int?;
    final duration = DateTime.now().millisecondsSinceEpoch - (startTime ?? 0);
    final userId = err.requestOptions.headers['user-id'] ?? 'unknown_user';

    await analyticsService.logEvent('api_error', {
      'url': err.requestOptions.path,
      'method': err.requestOptions.method,
      'duration_ms': duration,
      'user_id': userId,
      'status_code': err.response?.statusCode ?? 0,
      'error_message': err.message??"",
    });

    super.onError(err, handler);
  }
}
