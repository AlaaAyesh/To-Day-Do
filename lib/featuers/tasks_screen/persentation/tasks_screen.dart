import 'package:flutter/material.dart';
import '../widget/tasks_screen_body.dart';
import '../widget/tasks_screen_floating_action_button.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: TasksScreenFloatingActionButton(),
      body: TasksScreenBody(),
    );
  }
}
