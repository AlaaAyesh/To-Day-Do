class TaskModel {
   String taskName;
  bool isChecked;

  TaskModel({required this.taskName, this.isChecked = false});
   void checked() {
     isChecked = !isChecked;
   }
}
