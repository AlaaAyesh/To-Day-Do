import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/news_article.dart';

class NewsApi {
  static const String apiKey = "4678a583410d4f1bb234034cf4fa514a";
  static const String baseUrl = "https://newsapi.org/v2/top-headlines";
  static const String country = "us"; // Change this if needed

  static Future<List<NewsArticle>> fetchTopHeadlines() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?country=$country&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'ok') {
          final List<dynamic> articles = data['articles'];
          return articles.map((article) => NewsArticle.fromJson(article)).toList();
        } else {
          throw Exception('Failed to load news');
        }
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching news: $e');
      }
      throw Exception('Failed to load news');
    }
  }

  static Future<List<NewsArticle>> searchNews(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?q=$query&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'ok') {
          final List<dynamic> articles = data['articles'];
          return articles.map((article) => NewsArticle.fromJson(article)).toList();
        } else {
          throw Exception('Failed to search news');
        }
      } else {
        throw Exception('Failed to search news');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error searching news: $e');
      }
      throw Exception('Failed to search news');
    }
  }
}
