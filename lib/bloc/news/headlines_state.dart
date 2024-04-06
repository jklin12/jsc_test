part of 'headlines_bloc.dart';

@immutable
abstract class HeadlinesState {}

class HeadlinesInitial extends HeadlinesState {}

class HeadlinesPageLoading extends HeadlinesState {}


class HeadlinesPageLoaded extends HeadlinesState {
  late final List<ArticleModel> data;
  
  HeadlinesPageLoaded(this.data);
}


class HeadlinesPageError extends HeadlinesState {
  late final String errorMessage;
  HeadlinesPageError(this.errorMessage);
} 