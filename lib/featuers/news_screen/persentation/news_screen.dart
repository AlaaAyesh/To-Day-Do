import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/api/news_api.dart';
import '../../../core/models/news_article.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<NewsArticle>> futureNews;
  late List<NewsArticle> allNews = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    futureNews = NewsApi.fetchTopHeadlines();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchNews(String query) {
    if (query.isEmpty) {
      setState(() {
        futureNews = NewsApi.fetchTopHeadlines();
      });
    } else {
      setState(() {
        futureNews = NewsApi.searchNews(query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextField(
          controller: _searchController,
          onChanged: _searchNews,
          decoration: const InputDecoration(
            hintText: 'Search news...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<NewsArticle> news = snapshot.data as List<NewsArticle>;
            return ListView.separated(
              itemCount: news.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 16.0), // Add space between items
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (await canLaunch(news[index].url)) {
                            await launch(news[index].url);
                          } else {
                            throw 'Could not launch ${news[index].url}';
                          }
                        },
                        child: Image(
                          image: news[index].imageUrl.startsWith('http')
                              ? NetworkImage(news[index].imageUrl)
                              : AssetImage(news[index].imageUrl)
                          as ImageProvider<Object>,
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ListTile(
                        title: Text(news[index].title),
                        subtitle: Text(news[index].description),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
