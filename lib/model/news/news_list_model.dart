import 'package:jsc_test/model/news/article_model.dart';

class NewsListModel {
  NewsListModel({
    required this.status,
    required this.message,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final String message;
  final int totalResults;
  final List<ArticleModel> articles;

  factory NewsListModel.fromJson(Map<String, dynamic> json){
    return NewsListModel(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      totalResults: json["totalResults"] ?? 0,
      articles: json["articles"] == null ? [] : List<ArticleModel>.from(json["articles"]!.map((x) => ArticleModel.fromJson(x))),
    );
  }

}

