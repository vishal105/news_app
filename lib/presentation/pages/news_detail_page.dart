import 'package:flutter/material.dart';
import 'package:news_app/core/services/firebase_analytics_service.dart';
import 'package:news_app/di/injector.dart';
import 'package:news_app/domain/entities/news.dart';
import 'package:url_launcher/url_launcher.dart';

/// Page to display the details of a news article.
class NewsDetailPage extends StatelessWidget {
  final News news;
  static const String placeholderImage = 'assets/images/placeholder.png'; // Placeholder image path

  NewsDetailPage({required this.news});

  @override
  Widget build(BuildContext context) {
    sl<FirebaseAnalyticsService>().logEvent('view_news_detail', {'title': news.title});

    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout(context);
          } else {
            return _buildTabletWebLayout(context, constraints.maxWidth);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: news.urlToImage, // Use the same tag as in NewsItem
              child: _buildImage(context, news.urlToImage, double.infinity, 250),
            ),
            SizedBox(height: 16.0),
            Text(
              news.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'By ${news.author}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Text(news.description),
            SizedBox(height: 16.0),
            Text(news.content),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () => _launchURL(news.url),
              child: Text('Read more'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletWebLayout(BuildContext context, double width) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: news.urlToImage, // Use the same tag as in NewsItem
              child: _buildImage(context, news.urlToImage, width / 2 - 40, 400),
            ),
            SizedBox(width: 32.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'By ${news.author}',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 32.0),
                  Text(news.description, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 32.0),
                  Text(news.content, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 32.0),
                  TextButton(
                    onPressed: () => _launchURL(news.url),
                    child: Text('Read more'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, String? imageUrl, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: imageUrl != null && imageUrl.isNotEmpty
              ? NetworkImage(imageUrl)
              : AssetImage(placeholderImage) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
