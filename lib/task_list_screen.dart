import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/task_model.dart';
import '/viewmodels/task_viewmodel.dart';
import 'package:uuid/uuid.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          final tasks = viewModel.tasks;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Dismissible(
                key: Key(task.id.toString()),
                direction: DismissDirection.horizontal,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart ||
                      direction == DismissDirection.startToEnd) {
                    // Show a dialog box to confirm the deletion.
                    bool confirmDelete = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Delete Task"),
                          content: Text(
                              "Are you sure you want to delete this task?"),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            ElevatedButton(
                              child: Text("Delete"),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    return confirmDelete;
                  }
                  return false;
                },
                onDismissed: (direction) {
                  // Call a function to delete the task.
                  viewModel.removeTask(task);
                },
                child: CheckboxListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  value: task.isDone,
                  onChanged: (value) {
                    viewModel.toggleTask(task);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddTaskDialog(context);
        },
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Description',
                  )),
              SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                final Uuid _uuid = Uuid();
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();

                if (title.isNotEmpty) {
                  final task = Task(
                    id: _uuid.v4(),
                    title: title,
                    description: description,
                  );
                  Provider.of<TaskViewModel>(context, listen: false)
                      .addTask(task);
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
