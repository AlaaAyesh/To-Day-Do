import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../busines_logic/task_provider.dart';
import '../../../core/global/colors/app_color.dart';

class TasksScreenFloatingActionButton extends StatelessWidget {
  const TasksScreenFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        String? newTaskName;

        return FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Add Task',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              color: AppColors.greenSpringRain,
                              fontWeight: FontWeight.bold,
                            )),
                        TextField(
                          autofocus: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            newTaskName = value;
                          },
                          cursorColor: AppColors.greenSpringRain,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.greenSpringRain),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () {
                            if (newTaskName != null) {
                              taskProvider.addTask(newTaskName!);
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Cannot save an empty task'),
                                ),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.greenSpringRain,
                          ),
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          backgroundColor: AppColors.lightBeige,
          child: const Icon(Icons.add, color: AppColors.greenSpringRain),
        );
      },
    );
  }
}
