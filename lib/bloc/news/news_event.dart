part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class FetchNewsEvent extends NewsEvent {
  FetchNewsEvent();
}
class SearchNewsEvent extends NewsEvent {
  final String query;
  SearchNewsEvent(this.query);
}

class ClearSearchEvent extends NewsEvent {
  ClearSearchEvent();
}
 
