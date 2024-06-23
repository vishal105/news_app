import 'package:flutter/material.dart';
import 'package:news_app/presentation/pages/login_page.dart';
import 'package:news_app/presentation/pages/news_detail_page.dart';
import 'package:news_app/presentation/pages/news_list_page.dart';
import 'package:news_app/presentation/pages/splash_page.dart';
import 'package:news_app/domain/entities/news.dart';

/// Router for handling navigation in the application.
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/newsList':
        return MaterialPageRoute(builder: (_) => NewsListPage());
      case '/newsDetail':
        final news = settings.arguments as News;
        return MaterialPageRoute(builder: (_) => NewsDetailPage(news: news));
      default:
        return MaterialPageRoute(builder: (_) => SplashPage());
    }
  }
}
