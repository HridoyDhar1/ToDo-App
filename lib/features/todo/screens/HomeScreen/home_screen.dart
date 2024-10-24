import 'package:flutter/material.dart';
import 'package:todoapp/common/wigets/appbar/app_bar.dart';

import 'package:todoapp/features/todo/screens/CancelTask/cacnecl_task.dart';
import 'package:todoapp/features/todo/screens/CompleteTask/complete_task.dart';
import 'package:todoapp/features/todo/screens/HomeScreen/create_task.dart';


import 'package:todoapp/features/todo/screens/HomeScreen/widgets/task_count_container.dart';
import 'package:todoapp/features/todo/screens/ProfileScreen/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<Map<String, String>> taskList = [];
  int currentIndex = 0;

  String currentStatus = 'in_process'; // Default status
  // Function to calculate the number of tasks by their status
  int _getTaskCountByStatus(String status) {
    final count = taskList.where((task) => task['Status'] == status).length;
    return count;
  }

  
  // onTab function..
  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
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
           Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTask()));
              },
              child: const Icon(Icons.add),
            )
          : null, // Only show FAB on Home tab
      body: IndexedStack(
        index: currentIndex,
        children: [
          _buildHomeScreen(context),
       
          const CompleteTask(),
          const CacneclTask(),
          const ProfilePage(),
          // Profile screen without AppBar
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          _onTabTapped(index);
        },
        backgroundColor: Colors.teal,
         selectedItemColor: Colors.black, // Color of the selected item
  unselectedItemColor: Colors.white, // Color of unselected items
  type: BottomNavigationBarType.fixed,
        items: const [
          
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Complete'),
                    BottomNavigationBarItem(icon: Icon(Icons.cancel), label: 'Cancel'),
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
          const  SizedBox(height: 10),
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
           
          ],
        ),
      ),
    );
  }

}