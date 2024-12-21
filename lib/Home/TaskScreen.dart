import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrimeAppBarWithTitle(context, false)
          .getAppBarWithBackArrowTitle("Task", onBack: () {}),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              child: Text(
                "Task on mobile is coming soon",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new RichText(
            text: new TextSpan(
              children: [
                new TextSpan(
                  text: 'To view on task on web ',
                  style: new TextStyle(color: Colors.black,fontSize: 16),
                ),
                new TextSpan(
                  text: 'Click Here',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                          'https://app.trime.ai/');
                    },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
