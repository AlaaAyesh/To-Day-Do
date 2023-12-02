import 'package:flutter/material.dart';
import 'package:to_day_do/persentation/tasks/widget/show_edit_task_name.dart';

import '../../../core/global/colors/app_color.dart';
import '../../../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final int taskIndex;
  final void Function(bool?) checkboxChange;
  final void Function(String?)? editTaskName;
  final void Function() listTileDelete;
  final TaskModel previousTask;
  const TaskTile({
    Key? key,
    required this.isChecked,
    required this.taskTitle,
    required this.checkboxChange,
    required this.listTileDelete,
    this.editTaskName,
    required this.taskIndex,
    required this.previousTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: () {
          showEditTaskNameDialog(
            context: context,
            taskIndex: taskIndex,
            taskTitle: taskTitle,
            previousTask: previousTask,
          );
        },
        child: Text(
          taskTitle,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.greenSpringRain,
            fontFamily: 'Mueda City.ttf',
            decoration: isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            Checkbox(
              activeColor: AppColors.greenSpringRain,
              value: isChecked,
              onChanged: checkboxChange,
            ),
            IconButton(
                onPressed: listTileDelete,
                icon: const Icon(Icons.delete_rounded))
          ],
        ),
      ),
      // onLongPress: listTileDelete,
    );
  }
}