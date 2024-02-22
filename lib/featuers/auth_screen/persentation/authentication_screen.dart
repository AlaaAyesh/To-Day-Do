import 'package:flutter/material.dart';

import '../../../core/global/colors/app_color.dart';
import '../login/persentation/login.dart';
import '../signup/persentation/signup.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final gradientColors =
        isDarkMode ? darkThemeGradientColors : lightThemeGradientColors;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Welcome',
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontFamily: Theme.of(context).textTheme.bodyText1?.fontFamily,
              ),
            ),
            // elevation: 0,
            backgroundColor: Colors.transparent,
            bottom:  const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.account_circle_outlined),
                  text: "LOGIN ",
                ),
                Tab(
                  icon: Icon(Icons.account_box_outlined),
                  text: "SING UP ",
                ),
              ],
              indicatorColor: Colors.white,
              indicatorWeight: 5,
            ),
          ),
          body: const TabBarView(children: [LoginScreen(), SignUpScreen()]),
        ),
      ),
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
