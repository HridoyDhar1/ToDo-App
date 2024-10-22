import 'package:flutter/material.dart';
import 'package:todoapp/common/wigets/appbar/app_bar.dart';
import 'package:todoapp/common/wigets/snackbar/snack_bar.dart';
import 'package:todoapp/data/models/network_response.dart';
import 'package:todoapp/data/services/network_call.dart';

import 'package:todoapp/features/todo/screens/ProfileScreen/edit_profile.dart';
import 'package:todoapp/features/todo/screens/HomeScreen/widgets/task_count_container.dart';
import 'package:todoapp/utils/url/urls.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<Map<String, String>> taskList = [];
  int currentIndex = 0;
  int? _editingIndex;
  String currentStatus = 'in_process'; // Default status
bool _addNewTaskProgress=false;
  // Function to calculate the number of tasks by their status
  int _getTaskCountByStatus(String status) {
    final count = taskList.where((task) => task['Status'] == status).length;
    return count;
  }

  // Function to edit task
  void _editTask(Map<String, String> task, int index) {
    setState(() {
      titleController.text = task['Title']!;
      descriptionController.text = task['Description']!;
      currentStatus = task['Status']!; // Load the task's current status
      _editingIndex = index;
    });
    _showDialogBox(context, isEditing: true);
  }

  // Function to delete task
  void _deleteTask(int index) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  // Function to save task
  void _saveTask() {
    setState(() {
      taskList.add({
        'Title': titleController.text,
        'Description': descriptionController.text,
        'Status': currentStatus // Save the selected status
      });
    });
    _clearField();
  }

  // Function to update task
  void _updateTask() {
    setState(() {
      if (_editingIndex != null) {
        taskList[_editingIndex!] = {
          'Title': titleController.text,
          'Description': descriptionController.text,
          'Status': currentStatus // Update the status
        };
        _editingIndex = null;
      }
      _clearField();
    });
  }

  // Clear fields
  void _clearField() {
    titleController.clear();
    descriptionController.clear();
    currentStatus = 'in_process'; // Reset status to default
  }

  // onTab function..
  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  // Show dialog box for adding/editing tasks
  void _showDialogBox(BuildContext context, {bool isEditing = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Use StatefulBuilder to manage the dialog's internal state
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(isEditing ? "Edit Task" : "New Task"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person)),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Enter valid value';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.description)),
                              validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return 'Enter valid value';
                            }
                            return null;
                          },
                          maxLines: 5,
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isEditing) ...[
                    // const Text('Task Status'),
                    RadioListTile<String>(
                      title: const Text('In Process'),
                      value: 'in_process',
                      groupValue: currentStatus,
                      onChanged: (value) {
                        setState(() {
                          currentStatus = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Completed'),
                      value: 'completed',
                      groupValue: currentStatus,
                      onChanged: (value) {
                        setState(() {
                          currentStatus = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Canceled'),
                      value: 'canceled',
                      groupValue: currentStatus,
                      onChanged: (value) {
                        setState(() {
                          currentStatus = value!;
                        });
                      },
                    ),
                  ], // Only show status when editing
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                    if (isEditing) {
                      _updateTask(); // Call update method when editing
                    } else {
                      _saveTask(); // Call save method when adding new task
                    }
                    Navigator.of(context).pop();
                    }  },
                  child: Text(isEditing ? "Update" : "Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentIndex == 0 // Only show AppBar on Home tab
          ? CustomAppBar(
              onGoingTaskCount: _getTaskCountByStatus('in_process'),
            )
          : null,
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                _showDialogBox(context);
              },
              child: const Icon(Icons.add),
            )
          : null, // Only show FAB on Home tab
      body: IndexedStack(
        index: currentIndex,
        children: [
          _buildHomeScreen(context),
          const EditProfile(), // Profile screen without AppBar
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          _onTabTapped(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHomeScreen(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pass the dynamic task counts to TaskCountDetails
            TaskCountDetails(
              totalTaskCount: taskList.length, // Total tasks created
              inProcessCount: _getTaskCountByStatus('in_process'),
              completedCount: _getTaskCountByStatus('completed'),
              canceledCount: _getTaskCountByStatus('canceled'),
            ),
            const SizedBox(height: 20),
            const Text(
              "Recently Task",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  final task = taskList[index];
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
                        "Title: ${task['Title']}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Description: ${task['Description']}\nStatus: ${task['Status']}",
                        style: const TextStyle(color: Colors.black),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _editTask(
                                  task, index); // Edit button functionality
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteTask(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
Future<void> _addNewTask() async {
  setState(() {
    _addNewTaskProgress = true; // Set progress to true while the task is being added
  });

  try {
    Map<String, dynamic> requestBody = {
      'title': titleController.text.trim(),
      'description': descriptionController.text.trim(),
      'status': 'New', // Adjust status if needed
    };

    final NetworkResponse response = await NetworkCall.postRequest(
      url: Urls.addNewTask,
      body: requestBody, // Ensure the request body is sent
    );

    if (response.isSuccess) {
      // Add task locally after a successful network call
      _saveTask(); // This function will add the task to taskList
      showSnackBarMessage(context, 'New task added');
    } else {
      // Handle the error, you can show a dialog or a SnackBar with response.errorMessage
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add task: ${response.errorMessage}")),
      );
    }
  } catch (e) {
    // Handle unexpected errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An error occurred: $e")),
    );
  } finally {
    setState(() {
      _addNewTaskProgress = false; // Reset progress after completion
      _clearField(); // Clear the input fields (ensure it's only called once)
    });
  }
}

}
