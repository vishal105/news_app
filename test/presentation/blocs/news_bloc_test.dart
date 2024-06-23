import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/domain/entities/news.dart';
import 'package:news_app/domain/usecases/get_news_list.dart';
import 'package:news_app/presentation/blocs/news_bloc/news_bloc.dart';
import 'package:news_app/core/error/failure.dart';

import '../../mock_classes.mocks.dart';

void main() {
  late NewsBloc bloc;
  late MockGetNewsList mockGetNewsList;

  setUp(() {
    mockGetNewsList = MockGetNewsList();
    bloc = NewsBloc(getNewsList: mockGetNewsList);
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

  test('initial state should be NewsInitial', () {
    expect(bloc.state, NewsInitial());
  });

  blocTest<NewsBloc, NewsState>(
    'should get data from the usecase',
    build: () {
      when(mockGetNewsList(any))
          .thenAnswer((_) async => Right(newsList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetNewsEvent()),
    expect: () => [
      NewsLoading(),
      NewsLoaded(news: newsList),
    ],
    verify: (bloc) {
      verify(mockGetNewsList(any));
    },
  );

  blocTest<NewsBloc, NewsState>(
    'should emit [NewsLoading, NewsError] when data is unsuccessful',
    build: () {
      when(mockGetNewsList(any))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetNewsEvent()),
    expect: () => [
      NewsLoading(),
      NewsError(message: 'Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNewsList(any));
    },
  );
}
