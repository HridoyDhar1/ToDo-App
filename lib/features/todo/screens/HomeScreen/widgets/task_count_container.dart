import 'package:flutter/material.dart';
import 'package:todoapp/common/wigets/customcontainer/custom_task_container.dart';

class TaskCountDetails extends StatelessWidget {
  final int totalTaskCount; // Total number of tasks
  final int inProcessCount;
  final int completedCount;
  final int canceledCount;

  const TaskCountDetails({
    Key? key,
    required this.totalTaskCount, // Pass the total task count here
    required this.inProcessCount,
    required this.completedCount,
    required this.canceledCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display total number of tasks in the "On Going" container
            CustomContainerTask(
              colors: Colors.teal[200],
              subTitle: '$totalTaskCount Task', // Shows total tasks
              title: 'On Going',
              images: 'assets/icons/work-in-progress.png',
            ),
            const SizedBox(width: 10),
            CustomContainerTask(
              colors: Colors.pink[200],
              subTitle: '$inProcessCount Task',
              title: 'In Process',
              images: 'assets/icons/circular-arrow.png',
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomContainerTask(
              colors: Colors.blue[200],
              subTitle: '$completedCount Task',
              title: 'Completed',
              images: 'assets/icons/checklist.png',
            ),
            const SizedBox(width: 10),
            CustomContainerTask(
              colors: Colors.orange[200],
              subTitle: '$canceledCount Task',
              title: 'Canceled',
              images: 'assets/icons/close.png',
            ),
          ],
        ),
      ],
    );
  }
}
