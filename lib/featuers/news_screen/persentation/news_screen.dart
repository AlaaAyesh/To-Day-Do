import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/api/news_api.dart';
import '../../../core/models/news_article.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<NewsArticle>> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = NewsApi.fetchTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
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
                          // ignore: deprecated_member_use
                          if (await canLaunch(news[index].url)) {
                            // ignore: deprecated_member_use
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
