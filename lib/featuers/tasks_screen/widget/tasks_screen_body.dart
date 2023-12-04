import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day_do/persentation/tasks/widget/switch_theme_button.dart';
import 'package:to_day_do/persentation/tasks/widget/tasks_list.dart';

import '../../../busines_logic/task_provider.dart';
import '../../../core/global/colors/app_color.dart';

class TasksScreenBody extends StatelessWidget {
  const TasksScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) => Container(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
          bottom: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'To Day Do',
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
                    fontSize: 40,
                    fontFamily: 'Mueda City.ttf',
                  ),
                ),
                const ThemeToggleSwitch(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '  ${taskProvider.tasks.length} Tasks',
                  style:  TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
                    fontSize: 18,
                    fontFamily: 'Mueda City.ttf',
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (taskProvider.iconCheckedAll == false) {
                      taskProvider.makeAllTasksChecked();
                    } else {
                      taskProvider.removeAllTasksChecked();
                    }
                  },
                  icon:  Icon(
                    Icons.playlist_add_check,
                    size: 40,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Expanded(
              child: TasksList(),
            ),
          ],
        ),
      ),
    );
  }
}

