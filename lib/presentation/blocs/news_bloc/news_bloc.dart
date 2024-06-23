import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/domain/entities/news.dart';
import 'package:news_app/domain/usecases/get_news_list.dart';

part 'news_event.dart';
part 'news_state.dart';

/// BLoC to handle news events and states.
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsList getNewsList;

  NewsBloc({required this.getNewsList}) : super(NewsInitial()) {
    on<GetNewsEvent>((event, emit) async {
      emit(NewsLoading());
      final failureOrNews = await getNewsList(NoParams());
      emit(failureOrNews.fold(
            (failure) => NewsError(message: failure.message),
            (news) => NewsLoaded(news: news),
      ));
    });
  }
}
