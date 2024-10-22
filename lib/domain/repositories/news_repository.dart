import 'package:noticias_app/domain/entities/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getNews({int page = 1, String? category});
}
