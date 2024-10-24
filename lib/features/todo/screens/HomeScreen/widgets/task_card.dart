import 'package:flutter/material.dart';
import 'package:todoapp/data/models/task_model.dart';

class TaskCard extends StatefulWidget {
  final TaskModel taskModel;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({
    super.key, 
    required this.taskModel,
    required this.onEdit,  // Callback for editing
    required this.onDelete, // Callback for deleting
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const CircleAvatar(
          backgroundColor: Color(0xffF7FAFF),
          child: Icon(
            Icons.work,
            color: Colors.teal,
          ),
        ),
        title: Text(
          widget.taskModel.title ?? '',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.taskModel.description ?? '',
          style: const TextStyle(color: Colors.black),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: widget.onEdit,  // Edit task functionality
              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: widget.onDelete,  // Delete task functionality
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
