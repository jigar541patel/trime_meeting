import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({ Key? key }) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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