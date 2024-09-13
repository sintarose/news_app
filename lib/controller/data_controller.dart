import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      hasInternet = true;
      await fetchNewsFromAPI();
    } else {
      hasInternet = false;
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
      }
    } on Exception catch (_) {
      hasInternet = false;
    }
  }

  fetchNewsFromAPI() async {
    final response = await dio.get(
        'https://newsapi.org/v2/everything?q=bitcoin&from=2024-08-25&sortBy=publishedAt&apiKey=bd9934c750314feeb1fe65d556c9888c');
    if (response.statusCode == 200) {
      dataModel = NewsApiModel.fromJson(response.data);
      isLoading = false;
    } else {
      throw Exception('Failed to load news');
    }
    notifyListeners();
  }




}
