import 'package:flutter/material.dart';
import 'package:news_app/domain/entities/news.dart';
import 'package:news_app/presentation/pages/login_page.dart';
import 'package:news_app/presentation/pages/news_detail_page.dart';
import 'package:news_app/presentation/pages/news_list_page.dart';
import 'package:news_app/presentation/pages/splash_page.dart';

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
        return _buildDetailPageRoute(news);
      default:
        return MaterialPageRoute(builder: (_) => SplashPage());
    }
  }

  static PageRouteBuilder _buildDetailPageRoute(News news) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => NewsDetailPage(news: news),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
