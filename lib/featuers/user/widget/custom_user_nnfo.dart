import 'package:flutter/material.dart';

import '../../../core/global/colors/app_color.dart';
class CustomUserInfo extends StatelessWidget {
  const CustomUserInfo({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style:  TextStyle(
              color: theme.textTheme.bodyText1?.color,
              fontFamily:  theme.textTheme.bodyText1?.fontFamily,
              // fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1.5
            ),
          ),
          TextSpan(
            text: value,
            style:  TextStyle(
              color: theme.textTheme.bodyText1?.color,
              fontFamily:  theme.textTheme.bodyText1?.fontFamily,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
