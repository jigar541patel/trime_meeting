import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({ Key? key }) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.blue,
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //         // Get.toNamed(PageRoutes.Task);
      //     },
      //   ),
    );
  }
}