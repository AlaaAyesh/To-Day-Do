import 'package:flutter/material.dart';
import 'package:to_day_do/core/global/colors/app_color.dart';
import '../widget/home_app_bar.dart';
import '../widget/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final gradientColors = isDarkMode ? darkThemeGradientColors : lightThemeGradientColors;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: const SafeArea(
          child: Column(
            children: [
              HomeScreenAppBar(),
              HomeScreenBody(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  List<Color> get lightThemeGradientColors => [
    AppColors.mainColor1,
    AppColors.mainColor2,
  ];

  List<Color> get darkThemeGradientColors => [
    AppColors.mainColor5,
    AppColors.mainColor4,
  ];
}
