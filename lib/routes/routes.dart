import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsc_test/model/news/article_model.dart';
import 'package:jsc_test/ui/home_screen/home_screen.dart';
import 'package:jsc_test/ui/home_screen/news_detail_screen.dart';

import '../bloc/news/headlines_bloc.dart';

class Routes {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomeScreen.id:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HeadlinesBloc>.value(
            value: HeadlinesBloc(),
            child: const HomeScreen(),
          ),
        );
      case NewsDetailScreen.id:
        return MaterialPageRoute(
          builder: (context) {
            return NewsDetailScreen(articleModel: args as ArticleModel);
          },
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error while loading new page'),
        ),
      );
    });
  }
}
