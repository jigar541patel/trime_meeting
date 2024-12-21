import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateTaskPage extends StatefulWidget {
  dynamic taskArray;
  CreateTaskPage({Key? key, required this.taskArray}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  TextEditingController dateFeild = TextEditingController();
  String date = "";
  String descriptsion = "";
  String tag = "";
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
      setData().whenComplete(() => setState(() {}));
    });
  }

  setData() async {
    if (widget.taskArray?.isNotEmpty ?? false) {
      for (int i = 0; i < widget.taskArray!.length; i++) {}
      setState(() async {
        var Time = await DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(widget.taskArray[0].date));
        date = "Due By :" + Time;
        descriptsion = widget.taskArray[0].description;
        tag = widget.taskArray[0].tags[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TrimeAppBarWithTitle(context, true)
            .getAppBarWithBackArrowTitle("Task Details", onBack: () {
          Get.back();
        }),
        body: ListView(
          children: [
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                descriptsion,
                style: TextStyles.blueSimpleContent,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                date,
                style: TextStyles.cardTextStyles,
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "Sub Task",
                style: TextStyles.blueSimpleContent,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "",
                style: TextStyles.cardTextStyles,
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "Tags",
                style: TextStyles.blueSimpleContent,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                tag,
                style: TextStyles.cardTextStyles,
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "Documents",
                style: TextStyles.blueSimpleContent,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "",
                style: TextStyles.cardTextStyles,
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 0.6),
                  ),
                  margin: const EdgeInsets.only(left: 3, right: 3),
                  height: 40,

                  // width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Close",
                      style: TextStyles.blackSimpleContent,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(),
                    color: Colors.blue,
                  ),
                  margin: const EdgeInsets.only(left: 13, right: 3),
                  height: 40,

                  // width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                       Get.toNamed(PageRoutes.homePage);
                    },
                    child: Text(
                      "Exit",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "inter,SemiBold"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
