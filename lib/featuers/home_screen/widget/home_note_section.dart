import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../busines_logic/task_provider.dart';
import '../../../models/task_model.dart';

class HomeCheckedTasksSection extends StatelessWidget {
  const HomeCheckedTasksSection({
    Key? key,
    required this.sizeWidth,
    required this.sizeHeight,
    required this.theme,
  }) : super(key: key);

  final double sizeWidth;
  final double sizeHeight;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        List<String> checkedTasks = taskProvider.checkedTasks;
        List<TaskModel> tasks = taskProvider.tasks;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: sizeWidth * 0.5,
              height: sizeHeight * 0.3,
              child: checkedTasks.isEmpty
                  ? Image.asset('assets/app_images/no-task.png')
                  : checkedTasks.length == tasks.length
                  ? Image.asset('assets/app_images/list.png',
                  fit: BoxFit.fitWidth)
                  : ListView.builder(
                itemCount: checkedTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          checkedTasks[index],
                          style: TextStyle(
                            color: theme.textTheme.bodyText1?.color,
                            fontSize: 22,
                            fontFamily: 'Mueda City.ttf',
                          ),
                        ),
                        Icon(
                          Icons.check,
                          color: theme.iconTheme.color,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
