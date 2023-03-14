import 'package:flutter/material.dart';
import '/models/task_model.dart';
import '/providers/task_provider.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskProvider taskProvider;

  TaskViewModel({required this.taskProvider});

  List<Task> get tasks => taskProvider.tasks;

  void addTask(Task task) {
    taskProvider.addTask(task);
    notifyListeners();
  }

  void toggleTask(Task task) {
    taskProvider.toggleTask(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    taskProvider.updateTask(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    taskProvider.removeTask(task);
    notifyListeners();
  }
}
