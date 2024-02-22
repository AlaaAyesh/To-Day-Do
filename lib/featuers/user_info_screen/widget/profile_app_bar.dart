import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day_do/core/global/colors/app_color.dart';

import '../../../busines_logic/user_provider.dart';

class ProfileScreenAppBar extends StatelessWidget {
  const ProfileScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) => SliverAppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: isDarkMode?AppColors.mainColor4:AppColors.mainColor3,
        ),
        expandedHeight: 400,
        pinned: true,
        stretch: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            '${userProvider.firstName} ${userProvider.lastName}',
            style: TextStyle(
              color: isDarkMode?AppColors.mainColor4:AppColors.mainColor3,
              fontFamily:  theme.textTheme.bodyText1?.fontFamily,

            ),
          ),
          background: Hero(
            tag: Null,
            child: Image.network(
              userProvider.imageUrl ?? '',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
