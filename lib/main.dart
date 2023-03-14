import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import '/viewmodels/task_viewmodel.dart';
import 'task_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskViewModel(taskProvider: TaskProvider()),
      child: MaterialApp(
        title: 'To-Do List',
        home: TaskListScreen(),
      ),
    );
  }
}
