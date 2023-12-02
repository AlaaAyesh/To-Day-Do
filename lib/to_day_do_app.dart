import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day_do/persentation/tasks/persentation/tasks_screen.dart';

import 'busines_logic/theme_provider.dart';
import 'core/global/themes/app_themes.dart';

class ToDayDo extends StatelessWidget {
  const ToDayDo({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const TasksScreen(),
      ),
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              theme: lightTheme(),
              darkTheme: darkTheme(),
              themeMode:
                  themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: const TasksScreen(),
            );
          },
        );
      },
    );
  }
}
