import 'package:flutter/material.dart';
import '/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(
        id: '1213',
        title: 'Buy groceries',
        description: 'Milk, eggs, bread',
        isDone: false),
    Task(
        id: '1453',
        title: 'Take out the trash',
        description: 'Garbage and recycling',
        isDone: true),
    Task(
        id: '1234',
        title: 'Walk the dog',
        description: 'Around the block',
        isDone: false),
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

  void updateTask(Task task) {
    final index = tasks.indexWhere((t) => t.id == task.id);
    tasks[index] = task;
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
