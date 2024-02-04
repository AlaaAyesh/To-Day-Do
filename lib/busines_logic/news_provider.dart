import 'package:flutter/foundation.dart';
import '../core/api/news_api.dart';
import '../core/models/news_article.dart';

class NewsProvider extends ChangeNotifier {
  late List<NewsArticle> _news = []; // Global list to store news articles

  List<NewsArticle> get news => _news;

  NewsProvider() {
    fetchNews(); // Fetch news articles when the provider is initialized
  }

  Future<void> fetchNews() async {
    try {
      _news = await NewsApi.fetchTopHeadlines();
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        if (kDebugMode) {
          if (kDebugMode) {
        }
          print('Error fetching news: $error');
        }
      }
    }
  }
}
