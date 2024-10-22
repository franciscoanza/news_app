import 'package:noticias_app/domain/datasources/remote/news_remote_datasource.dart';
import 'package:noticias_app/domain/entities/article.dart';
import 'package:noticias_app/domain/repositories/news_repository.dart';

class NewsRepositoryImpl extends NewsRepository {
  final NewsRemoteDatasource datasource;

  NewsRepositoryImpl({required this.datasource});
  @override
  Future<List<Article>> getNews({int page = 1, String? category}) async {
    return datasource.getNews(page: page, category: category);
  }
}
