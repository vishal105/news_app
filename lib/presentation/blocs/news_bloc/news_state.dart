part of 'news_bloc.dart';

/// Abstract class representing news states.
abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

/// Initial state of news.
class NewsInitial extends NewsState {}

/// Loading state of news.
class NewsLoading extends NewsState {}

/// Loaded state of news with a list of news items.
class NewsLoaded extends NewsState {
  final List<News> news;

  NewsLoaded({required this.news});

  @override
  List<Object> get props => [news];
}

/// Error state of news.
class NewsError extends NewsState {
  final String message;

  NewsError({required this.message});

  @override
  List<Object> get props => [message];
}
