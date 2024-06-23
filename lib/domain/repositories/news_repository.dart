import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/domain/entities/news.dart';

/// Abstract class representing the news repository.
abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getNews();
}
