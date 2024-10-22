part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class LoadNews extends NewsEvent {
  final int page;
  final String? category;

  const LoadNews({this.page = 1, this.category});

  @override
  List<Object?> get props => [page, category];
}

class LoadMoreNews extends NewsEvent {
  final int page;
  final String? category;

  const LoadMoreNews({this.page = 1, this.category});

  @override
  List<Object?> get props => [page, category];
}
