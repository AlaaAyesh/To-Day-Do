import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../busines_logic/task_provider.dart';
import '../../../core/global/colors/app_color.dart';

class HomeTaskSection extends StatelessWidget {
  const HomeTaskSection({
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
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) =>  Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TODAY TASKS',
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontSize: 22,
                  fontFamily: 'Mueda City.ttf',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                taskProvider.tasks.isEmpty?' NO TASKS YET ':
                taskProvider.checkedTaskCount ==taskProvider.tasks.length? 'ALL TASKS COMPLETE ❤🤩':
                'TASKS COMPLETE ${taskProvider.checkedTaskCount}/${taskProvider.tasks.length}',
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontSize: 18,
                  fontFamily: 'Mueda City.ttf',
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
