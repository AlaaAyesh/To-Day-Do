import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/global/colors/app_color.dart';
import '../widget/drawer_content.dart';
import '../widget/home_app_bar/persentation/home_app_bar.dart';
import '../widget/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.auth}) : super(key: key);

  final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final gradientColors =
    isDarkMode ? darkThemeGradientColors : lightThemeGradientColors;

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return Scaffold(
          drawer: const DrawerContents(),
          appBar: HomeScreenAppBar(auth: auth),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradientColors,
              ),
            ),
            child: const SafeArea(
              child: HomeScreenBody(),
            ),
          ),
          backgroundColor: Colors.transparent,
        );
      },
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

