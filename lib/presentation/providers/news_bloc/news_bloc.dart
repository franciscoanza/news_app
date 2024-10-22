import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/article.dart';
import '../../../domain/repositories/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;
  int currentPage = 1;

  NewsBloc({required this.repository}) : super(NewsLoading()) {
    on<LoadNews>((event, emit) async {
      emit(NewsLoading());
      currentPage = 1; // Reiniciar la página al cargar nuevas noticias
      try {
        final articles = await repository.getNews(
            page: currentPage, category: event.category);
        emit(NewsLoaded(articles: articles, hasReachedMax: articles.isEmpty));
      } catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });

    on<LoadMoreNews>((event, emit) async {
      if (state is NewsLoaded) {
        final currentState = state as NewsLoaded;
        if (currentState.hasReachedMax) return;

        emit(NewsLoading(
            isLoadingMore: true)); // Emitir estado de cargando más noticias
        currentPage += 1; // Incrementar la página

        try {
          final articles = await repository.getNews(
              page: currentPage, category: event.category);
          emit(NewsLoaded(
            articles: currentState.articles +
                articles, // Combinar las noticias anteriores con las nuevas
            hasReachedMax: articles.isEmpty,
          ));
        } catch (e) {
          emit(NewsError(message: e.toString()));
        }
      }
    });
  }
}
