import 'package:equatable/equatable.dart';

/// Entity representing a News item.
class News extends Equatable {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String author;
  final String publishedAt;
  final String content;
  final String sourceName;

  News({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.author,
    required this.publishedAt,
    required this.content,
    required this.sourceName,
  });

  @override
  List<Object?> get props => [
    title,
    description,
    url,
    urlToImage,
    author,
    publishedAt,
    content,
    sourceName,
  ];
}
