import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubTaskPage extends StatefulWidget {
  const SubTaskPage({Key? key}) : super(key: key);

  @override
  State<SubTaskPage> createState() => _SubTaskPageState();
}

class _SubTaskPageState extends State<SubTaskPage> {
  TextEditingController dateFeild = TextEditingController();
  String date = "";
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        // String dateOnly = sele

        selectedDate = selected;
        // dateFeild.text = selected.toString();
        var date = DateTime.parse(selected.toString());
        var formattedDate = "${date.day}-${date.month}-${date.year}";
        dateFeild.text = formattedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TrimeAppBarWithTitle(context, true)
            .getAppBarWithBackArrowTitle("Add Sub Task", onBack: () {
          Get.back();
        }),
        body: ListView(
          children: [
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: const Text(
                "Description",
                style: TextStyles.blackSimpleContent,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColors.lightWhiteOpacityColor,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: InputBorder.none,
                    hintText: "Description"),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: const Text(
                "Due Date",
                style: TextStyles.blackSimpleContent,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColors.lightWhiteOpacityColor,
              ),
              child: TextFormField(
                readOnly: true,
                controller: dateFeild,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _selectDate(context);
                          });
                        },
                        icon: Icon(Icons.calendar_month)),
                    contentPadding: EdgeInsets.only(left: 20, top: 12),
                    border: InputBorder.none,
                    hintText: "dd/mm/yyyy"),
              ),
            ),
           SizedBox(height: 20),
            Container(
          alignment: Alignment.bottomRight,
                  height: 40,
                 
                  // width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        
                         Image.asset("Assets/Image/add.png",height: 13,width: 10,),
                        Text(
                        "  Sub Tasks",
                          style: TextStyle(fontSize: 14,fontFamily: "inter,SemiBold"),
                        ),
                      ],
                    ),
                  ),
                ),
           
          ],
        ),
      ),
    );
  }
}