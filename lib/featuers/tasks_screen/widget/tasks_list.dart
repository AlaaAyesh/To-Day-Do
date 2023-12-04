import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_day_do/persentation/tasks/widget/task_tile.dart';

import '../../../busines_logic/task_provider.dart';
import '../../../core/global/colors/app_color.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    return ListView.builder(
      itemCount: taskProvider.tasks.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightBeige.withOpacity(0.3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Dismissible(
                  key: ObjectKey(taskProvider.tasks[index]),
                  direction: DismissDirection.endToStart,
                  background:  Center(
                    child: Text(
                      'delete ',
                      style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  onDismissed: (direction) {
                    var removedTask = taskProvider.tasks[index];
                    taskProvider.removeTask(
                      removedTask,
                      context,
                    );
                  },
                  child: TaskTile(
                    isChecked: taskProvider.tasks[index].isChecked,
                    taskTitle: taskProvider.tasks[index].taskName,
                    checkboxChange: (isChecked) {
                      taskProvider.taskChecked(index);
                    },
                    listTileDelete: () {
                      taskProvider.removeTask(
                          taskProvider.tasks[index], context);
                    },
                    editTaskName: (value) {
                      taskProvider.editTaskTitle(index, value!);
                    },
                    taskIndex: index,
                    previousTask: taskProvider.tasks[index],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        );
      },
    );
  }
}
