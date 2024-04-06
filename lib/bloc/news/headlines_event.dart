part of 'headlines_bloc.dart';

@immutable
abstract class HeadlinesEvent {}

class FetchHeadlinesEvent extends HeadlinesEvent {
  FetchHeadlinesEvent();
}
