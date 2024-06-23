import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A class responsible for making API requests.
class ApiClient {
  final Dio dio;

  /// Initializes the ApiClient with a Dio instance.
  ApiClient(this.dio) {
    dio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';
  }

  /// Makes a GET request to the given URL.
  Future<Response> get(String url) async {
    return await dio.get(url);
  }
}
