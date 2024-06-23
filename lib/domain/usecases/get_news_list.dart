import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/domain/entities/news.dart';
import 'package:news_app/domain/repositories/news_repository.dart';

/// Use case for getting the news list.
class GetNewsList extends UseCase<List<News>, NoParams> {
  final NewsRepository repository;

  GetNewsList(this.repository);

  @override
  Future<Either<Failure, List<News>>> call(NoParams params) async {
    return await repository.getNews();
  }
}

/// No parameters for the use case.
class NoParams {}
