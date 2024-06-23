import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/data/datasources/remote/news_api_service.dart';
import 'package:news_app/domain/entities/news.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiService newsApiService;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    required this.newsApiService,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<News>>> getNews() async {
    if (await networkInfo.isConnected) {
      try {
        final news = await newsApiService.getNews();
        if (news.isEmpty) {
          return Left(ServerFailure('No data available'));
        }
        return Right(news);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }
}
