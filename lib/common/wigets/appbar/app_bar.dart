import 'package:flutter/material.dart';
import 'package:todoapp/features/todo/screens/ProfileScreen/edit_profile.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int onGoingTaskCount; // Add a parameter for the total On Going tasks

  const CustomAppBar({super.key, required this.onGoingTaskCount});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Colors.teal,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Hare Krishna"),
              const SizedBox(height: 5),
              Text(
                "$onGoingTaskCount On Going Tasks", // Display the On Going task count
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () => _appBarProfileIcon(context), // Pass the context here
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/icons/man-removebg-preview.png", // Ensure the path to your asset is correct
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80); // Set the height based on toolbarHeight

  void _appBarProfileIcon(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfile()),
    );
  }
}
