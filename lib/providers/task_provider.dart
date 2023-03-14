import 'package:flutter/material.dart';
import '/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(
        title: 'Buy groceries',
        description: 'Milk, eggs, bread',
        isDone: false),
    Task(
        title: 'Take out the trash',
        description: 'Garbage and recycling',
        isDone: true),
    Task(title: 'Walk the dog', description: 'Around the block', isDone: false),
  ];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTask(Task task) {
    final index = _tasks.indexOf(task);
    _tasks[index].isDone = !_tasks[index].isDone;
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
