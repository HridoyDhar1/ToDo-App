import 'package:todoapp/data/models/task_model.dart';

class TaskListModel {
  String? status;
  List<TaskModel>? taskList;

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskModel>[];
      json['data'].forEach((v) { // Add parentheses around 'v'
        taskList!.add(TaskModel.formJson(v)); // Also fixed 'formJson' typo
      });
    }
  }
}
