import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  bool iconCheckedAll = false;
  int checkedTaskCount = 0;
  List<String> checkedTasks = [];

  void addCheckedTask(String task) {
    checkedTasks.add(task);
    notifyListeners();
  }
  TaskProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final taskList = prefs.getStringList('taskNames') ?? [];
    final taskCheckedList = prefs.getStringList('taskChecked') ?? [];

    tasks = List.generate(taskList.length, (index) {
      final isChecked = taskCheckedList[index] == 'true';
      if (isChecked) {
        checkedTaskCount++;
        checkedTasks.add(taskList[index]); // Add checked task to checkedTasks list
      }
      return TaskModel(
        taskName: taskList[index],
        isChecked: isChecked,
      );
    });

    notifyListeners();
  }

  void _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final taskList = tasks.map((task) => task.taskName).toList();
    final taskCheckedList = tasks.map((task) => task.isChecked.toString()).toList();

    prefs.setStringList('taskNames', taskList);
    prefs.setStringList('taskChecked', taskCheckedList);
  }

  void addTask(String newTaskTitle) {
    tasks.add(TaskModel(taskName: newTaskTitle));
    _saveTasks();
    notifyListeners();
  }

  void makeAllTasksChecked() {
    for (var task in tasks) {
      if (!task.isChecked) {
        task.checked();
        checkedTaskCount++;
      }
    }
    iconCheckedAll = true;
    _saveTasks();
    notifyListeners();
  }

  void removeAllTasksChecked() {
    for (var task in tasks) {
      if (task.isChecked) {
        task.checked();
        checkedTaskCount--;
      }
    }
    iconCheckedAll = false;
    _saveTasks();
    notifyListeners();
  }

  void taskChecked(int index) {
    if (index >= 0 && index < tasks.length) {
      if (tasks[index].isChecked) {
        // Add the checked task to the checkedTasks list
        checkedTasks.remove(tasks[index].taskName);
        if (checkedTaskCount > 0) {
          checkedTaskCount--;
        }
      } else {
        // Remove the unchecked task from the checkedTasks list
        addCheckedTask(tasks[index].taskName);
        checkedTaskCount++;
      }
      tasks[index].isChecked = !tasks[index].isChecked;

      _saveTasks();
      notifyListeners();
    }
  }

  void editTaskTitle(int index, String newTitle) {
    if (index >= 0 && index < tasks.length) {
      tasks[index].taskName = newTitle;
      _saveTasks();
      notifyListeners();
    }
  }

  void removeTask(TaskModel task, BuildContext context) {
    tasks.remove(task);
    checkedTasks.remove(task.taskName);
    _saveTasks();
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task "${task.taskName}" deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            addTask(task.taskName);
          },
        ),
      ),
    );
  }
}
