import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  bool iconCheckedAll = false;
  int checkedTaskCount =0;
  TaskProvider() {
    // Load tasks from shared preferences when the provider is created.
    _loadTasks();
  }
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final taskList = prefs.getStringList('taskNames') ?? [];
    final taskCheckedList = prefs.getStringList('taskChecked') ?? [];

    tasks = List.generate(taskList.length, (index) {
      return TaskModel(
        taskName: taskList[index],
        isChecked: taskCheckedList[index] == 'true',
      );
    });

    notifyListeners();
  }

  void _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final taskList = tasks.map((task) => task.taskName).toList();
    final taskCheckedList =
        tasks.map((task) => task.isChecked.toString()).toList();

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
      if (task.isChecked == false) {
        task.checked();
        checkedTaskCount++;
      }
    }
    iconCheckedAll = true;
    notifyListeners();
  }

  void removeAllTasksChecked() {
    for (var task in tasks) {
      if (task.isChecked == true) {
        task.checked();
        checkedTaskCount--;
      }
    }
    iconCheckedAll = false;
    notifyListeners();
  }

  void taskChecked(int index) {
    if (index >= 0 && index < tasks.length) {
      if(tasks[index].isChecked==true){
        checkedTaskCount--;
      }
      else{
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
