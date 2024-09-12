import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/constants/local_db.dart';
import 'package:news_app/models/news_model.dart';

class DataController extends ChangeNotifier {
  DataController() {
    checkInternetConnection();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result);
    });
  }
  NewsApiModel? dataModel;
  bool hasInternet = true;
  bool isLoading = true;
  final dio = Dio();
  final dbHelper = DatabaseHelper();

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      hasInternet = true;
      await fetchNewsFromAPI();
    } else {
      hasInternet = false;
      await _loadNewsFromDB();
    }
    notifyListeners();
  }

  checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('newsapi.org');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasInternet = true;
        fetchNewsFromAPI();
      } else {
        hasInternet = false;
         _loadNewsFromDB();
      }
    } on Exception catch (_) {
      hasInternet = false;
      _loadNewsFromDB();
    }
  }

  fetchNewsFromAPI() async {
    final response = await dio.get(
        'https://newsapi.org/v2/everything?q=bitcoin&from=2024-06-25&sortBy=publishedAt&apiKey=bd9934c750314feeb1fe65d556c9888c');
    if (response.statusCode == 200) {
      dataModel = NewsApiModel.fromJson(response.data);
      saveNewsToDB();
      isLoading = false;
    } else {
      throw Exception('Failed to load news');
    }
    notifyListeners();
  }

  _loadNewsFromDB() async {
    List<Article> articles = await dbHelper.getArticles();
    dataModel = NewsApiModel(
        status: 'ok', totalResults: articles.length, articles: articles);
    isLoading = false;
    notifyListeners();
    isLoading = false;

    if (dataModel?.articles == null) {
      Get.snackbar('No valid network connection available', '',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } else {
      Get.snackbar('No network connection', 'Loading local data');
    }
  }

  saveNewsToDB() async {
    await dbHelper.deleteAllArticles();
    for (var article in dataModel!.articles!) {
      await dbHelper.insertArticle(article);
    }
  }
}
