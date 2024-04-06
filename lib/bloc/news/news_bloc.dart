import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jsc_test/repositiories/news/news_repo.dart';
import 'package:jsc_test/model/news/article_model.dart';
import 'package:jsc_test/model/news/news_list_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  late final InternetConnectionChecker connectionChecker;

  final _newsRepo = NewsRepo();

  int page = 1;
  bool haveMoreData = false;

  NewsBloc() : super(NewsInitial()) {
    on<FetchNewsEvent>(_fetchNews);
    on<SearchNewsEvent>(_searchNews);
    on<ClearSearchEvent>(_clearSearch);
    connectionChecker = InternetConnectionChecker();
  }

  FutureOr<void> _clearSearch(NewsEvent event, Emitter<NewsState> emit) async {
    if (event is ClearSearchEvent) {
      emit(NewsPageLoading());
      final localNews = await _newsRepo.fetchAllLocalNews();
      emit(NewsPageLoaded(localNews));
    }
  }

  FutureOr<void> _searchNews(NewsEvent event, Emitter<NewsState> emit) async {
    if (event is SearchNewsEvent) {
      emit(NewsPageLoading());
      List<ArticleModel> searchResult = [];

      final localNews = await _newsRepo.fetchAllLocalNews();
      localNews.map((e) {
        if (e.title.contains(event.query)) {
          searchResult.add(e);
        }
      }).toList();
      emit(NewsPageLoaded(searchResult));
    }
  }

  FutureOr<void> _fetchNews(NewsEvent event, Emitter<NewsState> emit) async {
    if (event is FetchNewsEvent) {
      emit(NewsPageLoading());
      bool hasConnection = await connectionChecker.hasConnection;
      try {
        if (hasConnection) {
          await _newsRepo
              .getEverything()
              .onError(
                  (error, stackTrace) => emit(NewsPageError(error.toString())))
              .then((value) async {
            NewsListModel newsListModel = NewsListModel.fromJson(value);

            if (newsListModel.status == "ok") {
              await _newsRepo.saveNewsLocally(articles: newsListModel.articles);
              final localNews = await _newsRepo.fetchAllLocalNews();
              emit(NewsPageLoaded(localNews));
            } else {
              emit(NewsPageError(newsListModel.message));
            }
          });
        } else {
          final localNews = await _newsRepo.fetchAllLocalNews();
          emit(NewsPageLoaded(localNews));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}
