import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/domain/entities/news.dart';
import 'package:news_app/domain/repositories/news_repository.dart';
import 'package:news_app/domain/usecases/get_news_list.dart';

import '../../mock_classes.mocks.dart';

void main() {
  late GetNewsList usecase;
  late MockNewsRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    usecase = GetNewsList(mockNewsRepository);
  });

  final newsList = [
    News(
      title: 'Test News',
      description: 'Test Description',
      url: 'https://test.com',
      urlToImage: 'https://test.com/image.png',
      author: 'Test Author',
      publishedAt: '2024-01-01T00:00:00Z',
      content: 'Test Content',
      sourceName: 'Test Source',
    ),
  ];

  test('should get list of news from the repository', () async {
    when(mockNewsRepository.getNews())
        .thenAnswer((_) async => Right(newsList));

    final result = await usecase(NoParams());

    expect(result, Right(newsList));
    verify(mockNewsRepository.getNews());
    verifyNoMoreInteractions(mockNewsRepository);
  });

  test('should return server failure when repository call is unsuccessful', () async {
    when(mockNewsRepository.getNews())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    final result = await usecase(NoParams());

    expect(result, isA<Left<Failure, List<News>>>());
    verify(mockNewsRepository.getNews());
    verifyNoMoreInteractions(mockNewsRepository);
  });

  test('should return no data failure when no news is returned', () async {
    when(mockNewsRepository.getNews())
        .thenAnswer((_) async => Right([]));

    final result = await usecase(NoParams());

    expect(result, isA<Right<Failure, List<News>>>());
    verify(mockNewsRepository.getNews());
    verifyNoMoreInteractions(mockNewsRepository);
  });
}
