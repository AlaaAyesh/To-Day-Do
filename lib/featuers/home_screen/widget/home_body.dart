import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:to_day_do/featuers/tasks_screen/persentation/tasks_screen.dart';

import '../../../busines_logic/task_provider.dart';
import 'home_news_section.dart';
import 'home_note_section.dart';
import 'home_setting_section.dart';
import 'home_task_section.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    final ThemeData theme = Theme.of(context);
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 2,
                  children: [
                    SizedBox(
                      width: sizeWidth * 0.5,
                      height: sizeHeight * 0.5,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TasksScreen()), // Corrected route
                          );
                        },
                        child: HomeTaskSection(
                            sizeWidth: sizeWidth,
                            sizeHeight: sizeHeight,
                            theme: theme),
                      ),
                    ),
                    HomeNewsSection(theme: theme, sizeHeight: sizeHeight),
                    HomeNoteSection(
                        sizeWidth: sizeWidth,
                        sizeHeight: sizeHeight,
                        theme: theme),
                    HomeSettingSection(
                        sizeWidth: sizeWidth,
                        sizeHeight: sizeHeight,
                        theme: theme),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
