import 'package:flutter/material.dart';
import '../../../core/global/colors/app_color.dart';
import '../widget/tasks_screen_body.dart';
import '../widget/tasks_screen_floating_action_button.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final gradientColors = isDarkMode ? darkThemeGradientColors : lightThemeGradientColors;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: const Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: TasksScreenFloatingActionButton(),
        body: TasksScreenBody(),
        backgroundColor: Colors.transparent,

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
