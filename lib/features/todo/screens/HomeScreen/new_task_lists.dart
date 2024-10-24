import 'package:flutter/material.dart';
import 'package:todoapp/data/models/task_list_model.dart';
import 'package:todoapp/data/models/task_model.dart';
import 'package:todoapp/features/todo/screens/HomeScreen/widgets/task_card.dart';
import 'package:todoapp/utils/url/urls.dart';

import '../../../../common/wigets/snackbar/snack_bar.dart';
import '../../../../data/models/network_response.dart';
import '../../../../data/services/network_call.dart';

class NewTaskLists extends StatefulWidget {
  const NewTaskLists({super.key});

  @override
  State<NewTaskLists> createState() => _NewTaskListsState();
}

class _NewTaskListsState extends State<NewTaskLists> {
  bool _getNewTaskInProgress = false;
  List<TaskModel> _newTaskList = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        _getNewTaskList();
      },
      child: SizedBox(
        height: 500,
        child: Visibility(
          visible: !_getNewTaskInProgress,
          replacement: const CircularProgressIndicator(),
          child: ListView.builder(
            itemCount: _newTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: _newTaskList[index], onEdit: () {  }, onDelete: () {  },
                
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getNewTaskList() async {
    _newTaskList.clear();
    _getNewTaskInProgress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCall.getRequest(url: Urls.newTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newTaskList = taskListModel.taskList ?? [];
      ;
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getNewTaskInProgress = false;

    setState(() {});
  }
}
