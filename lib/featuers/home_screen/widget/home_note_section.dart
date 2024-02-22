import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class HomeNoteSection extends StatelessWidget {
  const HomeNoteSection({
    super.key,
    required this.sizeWidth,
    required this.sizeHeight,
    required this.theme,
  });

  final double sizeWidth;
  final double sizeHeight;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/app_images/note.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        width: sizeWidth * 0.5,
        height: sizeHeight * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'NOTES',
              style: TextStyle(
                color: theme.textTheme.bodyLarge?.color,
                fontSize: 22,
                fontFamily: 'Mueda City.ttf',
              ),
            ),

          ],
        ),
      ),
    );
  }
}
