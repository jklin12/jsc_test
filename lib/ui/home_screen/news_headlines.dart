import 'package:flutter/material.dart';
import 'package:jsc_test/model/news/article_model.dart';
import 'package:jsc_test/ui/home_screen/news_detail_screen.dart';

class NewsHeadLines extends StatelessWidget {
  const NewsHeadLines({super.key, required this.newsList});

  final List<ArticleModel> newsList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return _newsListItems(context ,newsList[index]);
        },
      ),
    );
  }
  Widget _newsListItems(BuildContext context,ArticleModel article) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Card(
        child: ListTile(
          title: Text(
            article.title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(article.author,maxLines: 3,),
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushNamed(NewsDetailScreen.id, arguments: article);
          },
        ),
      ),
    );
  }
}
