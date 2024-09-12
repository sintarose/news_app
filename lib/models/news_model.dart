// news_api_model.dart

import 'package:json_annotation/json_annotation.dart';
part 'news_model.g.dart';

@JsonSerializable()
class NewsApiModel {
  String status;
  int totalResults;
  List<Article>? articles;

  NewsApiModel(
      {required this.status, required this.totalResults, this.articles});

  factory NewsApiModel.fromJson(Map<String, dynamic> json) {
    return NewsApiModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: json['articles'] != null
          ? (json['articles'] as List)
              .map((article) => Article.fromJson(article))
              .toList()
          : null,
    );
  }
}

@JsonSerializable()
class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}

@JsonSerializable()
class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}
