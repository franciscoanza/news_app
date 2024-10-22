// To parse this JSON data, do
//
//     final newsApiResponse = newsApiResponseFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/article.dart';

NewsApiResponse newsApiResponseFromJson(String str) =>
    NewsApiResponse.fromJson(json.decode(str));

String newsApiResponseToJson(NewsApiResponse data) =>
    json.encode(data.toJson());

class NewsApiResponse {
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  NewsApiResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  NewsApiResponse copyWith({
    String? status,
    int? totalResults,
    List<Article>? articles,
  }) =>
      NewsApiResponse(
        status: status ?? this.status,
        totalResults: totalResults ?? this.totalResults,
        articles: articles ?? this.articles,
      );

  factory NewsApiResponse.fromJson(Map<String, dynamic> json) =>
      NewsApiResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: json["articles"] == null
            ? []
            : List<Article>.from(
                json["articles"]!.map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles == null
            ? []
            : List<dynamic>.from(articles!.map((x) => x.toJson())),
      };
}
