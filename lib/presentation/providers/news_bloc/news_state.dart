part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsState {
  NewsLoading({this.isLoadingMore = false});
  final bool isLoadingMore;

  @override
  List<Object?> get props => [isLoadingMore];
}

class NewsLoaded extends NewsState {
  final List<Article> articles;
  final bool hasReachedMax;

  NewsLoaded({required this.articles, required this.hasReachedMax});

  @override
  List<Object?> get props => [articles, hasReachedMax];
}

class NewsError extends NewsState {
  final String message;

  NewsError({required this.message});

  @override
  List<Object?> get props => [message];
}
