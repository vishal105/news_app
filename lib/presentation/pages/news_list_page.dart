import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/blocs/news_bloc/news_bloc.dart';
import 'package:news_app/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:news_app/presentation/widgets/news_item.dart';
import 'package:news_app/di/injector.dart';
import 'package:news_app/core/utils/responsive.dart';
import 'package:news_app/core/services/firebase_analytics_service.dart';

import '../../domain/entities/news.dart';

/// Page to display a list of news articles.
class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NewsBloc>()..add(GetNewsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('News List'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
              },
            ),
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Unauthenticated) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
            ),
            BlocListener<NewsBloc, NewsState>(
              listener: (context, state) {
                if (state is NewsLoaded) {
                  sl<FirebaseAnalyticsService>().logEvent('view_news_list', null);
                }
              },
            ),
          ],
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is NewsLoaded) {
                if (state.news.isEmpty) {
                  return _buildNoDataUI(context);
                } else {
                  return _buildNewsList(context, state.news);
                }
              } else if (state is NewsError) {
                return _buildErrorUI(context, state.message);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNoDataUI(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No Data Available'),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorUI(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList(BuildContext context, List<News> newsList) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Responsive(
                mobile: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final news = newsList[index];
                    return NewsItem(news: news);
                  },
                ),
                tablet: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final news = newsList[index];
                    return NewsItem(news: news);
                  },
                ),
                desktop: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final news = newsList[index];
                    return NewsItem(news: news);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
