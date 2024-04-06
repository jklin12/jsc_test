import 'package:hive/hive.dart';
import 'package:jsc_test/services/api_end_points.dart';
import 'package:jsc_test/services/base_api_service.dart';
import 'package:jsc_test/services/news_api_service.dart';

import '../../model/news/article_model.dart';

class NewsRepo  {

  static const headlineKey = 'headlines';
  static const newsKey = 'newsKey';

  final BaseApiService _apiService = NewskApiService();
 
  Future getHeadlinesData() async {
    try {
      dynamic response = await _apiService.getHeadlinesNewsResponse(
          ApiEndPoints().getHeadlinesNews);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future getEverything() async {
    try {
      dynamic response = await _apiService.getEverythingNewsResponse(
          ApiEndPoints().getEverythingNews);
      return response;
    } catch (e) {
      rethrow;
    }
  }
 


  Future<void> saveHeadlinesLocally({
    required List<ArticleModel> articles,
  }) async {
    final articleBox = await Hive.openBox<ArticleModel>(headlineKey);
    for (final article in articles) {
      await articleBox.put(article.author,article,);
    }
  }

  Future<List<ArticleModel>> fetchAllLocalHeadlines() async {
    final articleBox = await Hive.openBox<ArticleModel>(headlineKey);
    final localHeadlines = articleBox.values.toList();
    return localHeadlines;
  }
  Future<void> saveNewsLocally({
    required List<ArticleModel> articles,
  }) async {
    final articleBox = await Hive.openBox<ArticleModel>(newsKey);
    for (final article in articles) {
      await articleBox.put(article.author,article,);
    }
  }

  Future<List<ArticleModel>> fetchAllLocalNews() async {
    final articleBox = await Hive.openBox<ArticleModel>(newsKey);
    final localHeadlines = articleBox.values.toList();
    return localHeadlines;
  }
}
