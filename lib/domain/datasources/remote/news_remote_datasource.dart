import 'package:noticias_app/domain/entities/article.dart';

abstract class NewsRemoteDatasource {
  Future<List<Article>> getNews({int page = 1, String? category});
}
