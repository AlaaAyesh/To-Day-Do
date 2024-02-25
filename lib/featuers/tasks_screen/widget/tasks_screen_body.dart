import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day_do/featuers/tasks_screen/widget/switch_theme_button.dart';
import 'package:to_day_do/featuers/tasks_screen/widget/tasks_list.dart';
import '../../../busines_logic/task_provider.dart';

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
          left: 6,
          right: 6,
          bottom: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    )),
                Text(
                  'To Day Do',
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
                    fontSize: 40,
                    fontFamily: 'Mueda City.ttf',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '  ${taskProvider.tasks.length} Tasks',
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
                    fontSize: 18,
                    fontFamily: 'Mueda City.ttf',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ThemeToggleSwitch(),
                    IconButton(
                      onPressed: () {
                        if (taskProvider.iconCheckedAll == false) {
                          taskProvider.makeAllTasksChecked();
                        } else {
                          taskProvider.removeAllTasksChecked();
                        }
                      },
                      icon: Icon(
                        Icons.playlist_add_check,
                        size: 40,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
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
