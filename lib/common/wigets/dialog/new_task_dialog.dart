// import 'package:flutter/material.dart';
// import 'package:todoapp/features/todo/screens/LoginScreen/widgets/text_fields.dart';

// class NewTaskDialog extends StatefulWidget {
//   const NewTaskDialog({super.key});

//   @override
//   State<NewTaskDialog> createState() => _NewTaskDialogState();
// }

// class _NewTaskDialogState extends State<NewTaskDialog> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();

//   int? _editingIndex;
//   List<Map<String, String>> taskList = [];
//   bool isEditing = false; // Variable to track if we are editing
//   String currentStatus = 'in_process'; // Task status

//   // Function for editing a task
//   void _editTask(Map<String, String> task, int index) {
//     setState(() {
//       _titleController.text = task['Title']!;
//       _descriptionController.text = task['Description']!;
//       currentStatus = task['Status'] ?? 'in_process'; // Default to 'in_process'
//       _editingIndex = index;
//       isEditing = true;
//     });
//   }

//   // Function for deleting a task
//   void _deleteTask(int index) {
//     setState(() {
//       taskList.removeAt(index);
//     });
//   }

//   // Function for saving a new task
//   void _saveTask() {
//     setState(() {
//       taskList.add({
//         'Title': _titleController.text,
//         'Description': _descriptionController.text,
//         'Status': currentStatus
//       });
//     });
//     _clearField();
//   }

//   // Function for updating an existing task
//   void _updateTask() {
//     setState(() {
//       if (_editingIndex != null) {
//         taskList[_editingIndex!] = {
//           'Title': _titleController.text,
//           'Description': _descriptionController.text,
//           'Status': currentStatus
//         };
//         _editingIndex = null;
//         isEditing = false;
//       }
//     });
//     _clearField();
//   }

//   // Function for clearing input fields
//   void _clearField() {
//     _titleController.clear();
//     _descriptionController.clear();
//     currentStatus = 'in_process'; // Reset to default status
//     isEditing = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(isEditing ? "Edit Task" : "New Task"),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           CustomTextField(
//             name: "Title",
//             icons: Icons.person,
//             keyboardTypes: TextInputType.text,
//             controller: _titleController,
//             valid: 'Enter the title of task',
//           ),
//           const SizedBox(height: 10),
//           CustomTextField(
//             name: "Description",
//             icons: Icons.description,
//             keyboardTypes: TextInputType.text,
//             controller: _descriptionController,
//             valid: 'Enter the description',
//           ),
//           const SizedBox(height: 10),
//           if (isEditing) // Show status options only when editing
//             Column(
//               children: [
//                 RadioListTile<String>(
//                   title: const Text('In Process'),
//                   value: 'in_process',
//                   groupValue: currentStatus,
//                   onChanged: (value) {
//                     setState(() {
//                       currentStatus = value!;
//                     });
//                   },
//                 ),
//                 RadioListTile<String>(
//                   title: const Text('Completed'),
//                   value: 'completed',
//                   groupValue: currentStatus,
//                   onChanged: (value) {
//                     setState(() {
//                       currentStatus = value!;
//                     });
//                   },
//                 ),
//                 RadioListTile<String>(
//                   title: const Text('Canceled'),
//                   value: 'canceled',
//                   groupValue: currentStatus,
//                   onChanged: (value) {
//                     setState(() {
//                       currentStatus = value!;
//                     });
//                   },
//                 ),
//               ],
//             ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text(
//             "Cancel",
//             style: TextStyle(color: Colors.red),
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             if (isEditing) {
//               _updateTask(); // Call update method when editing
//             } else {
//               _saveTask(); // Call save method when adding a new task
//             }
//             Navigator.of(context).pop();
//           },
//           child: Text(isEditing ? "Update" : "Save"),
//         ),
//       ],
//     );
//   }
// }
