import 'package:flutter/material.dart';
import 'package:todoapp/common/wigets/snackbar/snack_bar.dart';
import 'package:todoapp/data/models/network_response.dart';
import 'package:todoapp/data/models/task_list_model.dart';

class CompleteTask extends StatefulWidget {
  const CompleteTask({super.key});

  @override
  State<CompleteTask> createState() => _CompleteTaskState();
}

class _CompleteTaskState extends State<CompleteTask> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
  // Future<void> _getNewTaskList() async {
  //   _newTaskList.clear();
  //   _getNewTaskInProgress = true;
  //   setState(() {});

  //   final NetworkResponse response =
  //       await NetworkCall.getRequest(url: Urls.newTaskList);

  //   if (response.isSuccess) {
  //     final TaskListModel taskListModel =
  //         TaskListModel.fromJson(response.responseData);
  //     _newTaskList = taskListModel.taskList ?? [];
  //     ;
  //   } else {
  //     showSnackBarMessage(context, response.errorMessage, true);
  //   }
  //   _getNewTaskInProgress = false;

  //   setState(() {});
  // }
}

