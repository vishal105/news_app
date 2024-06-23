import 'package:news_app/domain/entities/news.dart';

/// Data model for News, extending the News entity.
class NewsModel extends News {
  NewsModel({
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String author,
    required String publishedAt,
    required String content,
    required String sourceName,
  }) : super(
    title: title,
    description: description,
    url: url,
    urlToImage: urlToImage,
    author: author,
    publishedAt: publishedAt,
    content: content,
    sourceName: sourceName,
  );

  /// Factory constructor to create NewsModel from JSON.
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      author: json['author'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
      sourceName: json['source']['name'] ?? '',
    );
  }

  /// Converts the NewsModel to JSON.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'author': author,
      'publishedAt': publishedAt,
      'content': content,
      'source': {'name': sourceName},
    };
  }
}
