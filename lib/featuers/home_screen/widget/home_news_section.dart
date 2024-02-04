import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../busines_logic/news_provider.dart';
import '../../../core/models/news_article.dart';
class HomeNewsSection extends StatelessWidget {
  const HomeNewsSection({
    super.key,
    required this.theme,
    required this.sizeHeight,
  });

  final ThemeData theme;
  final double sizeHeight;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 16,
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            'NEWS',
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontSize: 22,
              fontFamily: 'Mueda City.ttf',
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            height: sizeHeight * 0.8,
            child: Consumer<NewsProvider>(
              builder: (context, newsProvider, child) {
                final List<NewsArticle> news = newsProvider.news;
                return GridView.custom(
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                    pattern: const [
                      QuiltedGridTile(2, 2),
                      QuiltedGridTile(1, 1),
                      QuiltedGridTile(1, 1),
                      QuiltedGridTile(1, 2),
                      QuiltedGridTile(1, 2),
                    ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) => GestureDetector(
                      onTap: () async {
                        if (await canLaunch(news[index].url)) {
                          await launch(news[index].url);
                        } else {
                          throw 'Could not launch ${news[index].url}';
                        }
                      },
                      child: Card(
                        elevation: 16.0,
                        child: Image(
                          image: news[index].imageUrl.startsWith('http')
                              ? NetworkImage(news[index].imageUrl)
                              : AssetImage(news[index].imageUrl)
                          as ImageProvider<Object>,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    childCount: news.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
