import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../busines_logic/task_provider.dart';
import '../../../core/global/colors/app_color.dart';
import '../../../models/task_model.dart';

Future<void> showEditTaskNameDialog({
  required BuildContext context,
  required TaskModel previousTask,
  required int taskIndex,
  required String taskTitle,
}) async {
  TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
  String newTaskTitle = taskTitle;

  await showDialog(
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: AlertDialog(
          title: const Text('Edit Task',
              style: TextStyle(color: AppColors.greenSpringRain)),
          content: TextField(
            cursorColor: AppColors.greenSpringRain,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.greenSpringRain),
              ),
            ),
            autofocus: true,
            onChanged: (value) {
              newTaskTitle = value;
            },
            controller: TextEditingController(text: taskTitle),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save',
                  style: TextStyle(color: AppColors.greenSpringRain)),
              onPressed: () {
                Navigator.of(context).pop();
                if (newTaskTitle.isNotEmpty) {
                  taskProvider.editTaskTitle(taskIndex, newTaskTitle);
                } else {
                  taskProvider.removeTask(previousTask,context);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
