part of 'news_bloc.dart';

/// Abstract class representing news events.
abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

/// Event to get news.
class GetNewsEvent extends NewsEvent {}
