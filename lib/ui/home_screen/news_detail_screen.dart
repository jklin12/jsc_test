import 'package:flutter/material.dart';
import 'package:jsc_test/model/news/article_model.dart';

class NewsDetailScreen extends StatefulWidget {
  static const String id = "news_detail_screen";
  final ArticleModel articleModel;

  const NewsDetailScreen({super.key, required this.articleModel});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.articleModel.urlToImage!.isNotEmpty
                ? Image.network(
                    widget.articleModel.urlToImage!,
                    width: MediaQuery.of(context).size.width,
                  )
                : Container(),
            Text(
              widget.articleModel.title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(
              widget.articleModel.author,
            ),
            Text(
              widget.articleModel.description ?? '',
            )
          ],
        ),
      ),
    );
  }
}
