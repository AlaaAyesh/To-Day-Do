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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final gradientColors =
        isDarkMode ? darkThemeGradientColors : lightThemeGradientColors;

    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        String? newTaskName;

        return FloatingActionButton(
          backgroundColor: isDarkMode
              ? AppColors.mainColor1.withOpacity(0.6)
              : AppColors.mainColor4,
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (context) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradientColors,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Add Task',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color,
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.fontFamily,
                              )),
                          TextField(
                            autofocus: true,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              newTaskName = value;
                            },
                            cursorColor: theme.textTheme.bodyText1?.color,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? AppColors.mainColor1.withOpacity(0.6)
                                        : AppColors.mainColor4),
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
                              foregroundColor: isDarkMode
                                  ? AppColors.mainColor4
                                  : AppColors.mainColor1,
                              backgroundColor: isDarkMode
                                  ? AppColors.mainColor1.withOpacity(0.2)
                                  : AppColors.mainColor4,
                            ),
                            child: const Text('Add',
                              style: TextStyle(
                                color:AppColors.mainColor1,
                                fontSize: 18,
                                fontFamily: 'Mueda City.ttf',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        );
      },
    );
  }

  List<Color> get lightThemeGradientColors => [
        AppColors.mainColor1,
        AppColors.mainColor2,
      ];

  List<Color> get darkThemeGradientColors => [
        AppColors.mainColor5,
        AppColors.mainColor4,
      ];
}
