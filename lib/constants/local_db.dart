// db_helper.dart

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:news_app/models/news_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'news_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE articles (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            source TEXT,
            author TEXT,
            title TEXT,
            description TEXT,
            url TEXT,
            urlToImage TEXT,
            publishedAt TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertArticle(Article article) async {
    final db = await database;
    await db.insert(
      'articles',
      article.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Article>> getArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('articles');
    return List.generate(maps.length, (i) {
      return Article.fromJson(maps[i]);
    });
  }

  Future<void> deleteAllArticles() async {
    final db = await database;
    await db.delete('articles');
  }
}

extension ArticleJson on Article {
  Map<String, dynamic> toJson() {
    return {
      'source': source?.name,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
