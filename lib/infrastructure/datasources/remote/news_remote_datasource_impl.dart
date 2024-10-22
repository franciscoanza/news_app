import 'package:dio/dio.dart';
import 'package:noticias_app/config/environment.dart';
import 'package:noticias_app/domain/datasources/remote/news_remote_datasource.dart';
import 'package:noticias_app/domain/entities/article.dart';
import 'package:noticias_app/infrastructure/models/news_api_response.dart';

class NewsRemoteDatasourceImpl extends NewsRemoteDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://newsapi.org/v2/',
  ));

  @override
  Future<List<Article>> getNews({int page = 1, String? category}) async {
    try {
      final response = await dio.get(
        'top-headlines',
        queryParameters: {
          'country': 'us',
          'apiKey': Environment.newsApiKey,
          'page': page,
          'pageSize': 20,
          if (category != null) 'category': category,
        },
      );
      if (response.statusCode == 200) {
        final newsResponse = NewsApiResponse.fromJson(response.data);
        final List<Article> newsList = newsResponse.articles ?? [];
        return newsList;
      } else {
        throw Exception(
            'Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(
          'DioException: ${e.response?.statusCode} - ${e.response?.statusMessage}');
    } catch (e) {
      throw Exception('Unhandled error: $e');
    }
  }
}
