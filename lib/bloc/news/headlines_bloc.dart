import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:jsc_test/model/news/article_model.dart';
import 'package:jsc_test/model/news/news_list_model.dart';
import 'package:jsc_test/repositiories/news/news_repo.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'headlines_event.dart';
part 'headlines_state.dart';

class HeadlinesBloc extends Bloc<HeadlinesEvent, HeadlinesState> {
  late final InternetConnectionChecker connectionChecker;

  final _newsRepo = NewsRepo();

  int page = 1;
  bool haveMoreData = false;

  HeadlinesBloc() : super(HeadlinesInitial()) {
    on<FetchHeadlinesEvent>(_fetchHeadlineNews);
    connectionChecker = InternetConnectionChecker();
  }

  FutureOr<void> _fetchHeadlineNews(
      HeadlinesEvent event, Emitter<HeadlinesState> emit) async {
    if (event is FetchHeadlinesEvent) {
      emit(HeadlinesPageLoading());
      bool hasConnection = await connectionChecker.hasConnection;
      try {
        if (hasConnection) {
          await _newsRepo
              .getHeadlinesData()
              .onError(
                  (error, stackTrace) => emit(HeadlinesPageError(error.toString())))
              .then((value) async {
            NewsListModel newsListModel = NewsListModel.fromJson(value);

            if (newsListModel.status == "ok") {
              await _newsRepo.saveHeadlinesLocally(
                  articles: newsListModel.articles);
              final localHeadlines = await _newsRepo.fetchAllLocalHeadlines();
              emit(HeadlinesPageLoaded(localHeadlines));
            } else {
              emit(HeadlinesPageError(newsListModel.message));
            }
          });
        } else {
          final localHeadlines = await _newsRepo.fetchAllLocalHeadlines();
          emit(HeadlinesPageLoaded(localHeadlines));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

   
}
