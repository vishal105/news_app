import 'package:dio/dio.dart';
import 'package:news_app/core/network/api_client.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../core/error/exceptions.dart';

/// Abstract class representing the News API service.
abstract class NewsApiService {
  Future<List<NewsModel>> getNews();
}

/// Implementation of NewsApiService using Dio for API requests.
class NewsApiServiceImpl implements NewsApiService {
  final ApiClient apiClient;

  NewsApiServiceImpl(this.apiClient);

  @override
  Future<List<NewsModel>> getNews() async {
    final apiKey = dotenv.env['API_KEY'] ?? '';
    try {
      final response = await apiClient.get('/v2/everything?q=singapore&sortBy=publishedAt&apiKey=$apiKey');
      if (response.statusCode == 200) {
        return (response.data['articles'] as List)
            .map((json) => NewsModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(message: 'Failed to load news data');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw ServerException(message: 'Failed to load news data: ${e.response?.statusCode} ${e.response?.statusMessage}');
      } else {
        throw ServerException(message: 'Failed to load news data: ${e.message}');
      }
    } catch (e) {
      throw ServerException(message: 'An unexpected error occurred');
    }
  }
}
