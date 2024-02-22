import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:to_day_do/featuers/tasks_screen/persentation/tasks_screen.dart';

import '../../../busines_logic/task_provider.dart';
import '../../tasks_screen/widget/tasks_screen_floating_action_button.dart';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: sizeHeight * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
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
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TasksScreen()), // Corrected route
                          );
                        },
                        child: HomeNoteSection(
                            sizeWidth: sizeWidth,
                            sizeHeight: sizeHeight,
                            theme: theme),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: sizeHeight * 0.25,
                  child: HomeNewsSection(theme: theme, sizeHeight: sizeHeight)),
            ],
          ),
        ),
      ),
    );
  }
}
