import 'package:flutter/material.dart';
class HomeSearchField extends StatelessWidget {
  const HomeSearchField({
    super.key,
    required this.sizeHeight,
    required this.sizeWidth,
    required this.theme,
  });

  final double sizeHeight;
  final double sizeWidth;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: sizeHeight * 0.06,
        width: sizeWidth * 1,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadiusDirectional.circular(73)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Text(
                'search ',
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontSize: 18,
                  fontFamily: 'Mueda City.ttf',
                ),
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
      ),
    );
  }
}
