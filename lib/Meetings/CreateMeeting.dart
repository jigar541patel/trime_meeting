import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateMeetingPage extends StatefulWidget {
  const CreateMeetingPage({Key? key}) : super(key: key);

  @override
  State<CreateMeetingPage> createState() => _CreateMeetingPageState();
}

class _CreateMeetingPageState extends State<CreateMeetingPage> {
  TextEditingController Description = TextEditingController();
  TextEditingController dateFeild = TextEditingController();
  TextEditingController TimeDetail = TextEditingController();
  TextEditingController Participant = TextEditingController();
  TextEditingController conference = TextEditingController();
  String date = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

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

  String dropdownvalue = '15 Min';
  var items = [
    '15 Min',
    '30 Min',
    '45 Min',
    '1 Hour',
    '1 Hrs 15 Min',
    '1 Hrs 30 Min',
    '1 Hrs 45 Min',
    '2 Hour',
    '2 Hrs 15 Min',
    '2 Hrs 30 Min',
    '2 Hrs 45 Min',
    '3 Hour',
    '3 Hrs 15 Min',
    '3 Hrs 30 Min',
    '3 Hrs 45 Min',
    '4 Hour '
  ];
  String dropdownvalue1 = 'One Time';
  var list = ['One Time'];
  // TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void _selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        var Time = TimeOfDay.now();
        var FormatTime = "${_time.hour}:${_time.minute}";
        TimeDetail.text = FormatTime;
      });
    }
  }

  // CreateMeeting() async {
  //   var id = await sharePrefrence.getString("userId");
  //   Map parameter = {
  //     "owner_id": id,
  //   };
  //   var url = Url.createMeeting;
  //   if (Description.text.isEmpty) {
  //     CommonUtils.toastMessage("Description is Required?");
  //   } else if (dateFeild.text.isEmpty) {
  //     CommonUtils.toastMessage("Date Field is Required?");
  //   } else if (TimeDetail.text.isEmpty) {
  //     CommonUtils.toastMessage("Time Field is Required?");
  //   } else if (Participant.text.isEmpty) {
  //     CommonUtils.toastMessage("Participant is Required?");
  //   } else if (Participant.text.isEmpty) {
  //     CommonUtils.toastMessage("Conferencing is Required?");
  //   } else {
  //     var result = await ApiManager.CreateMeetingApi(parameter);
  //     CommonUtils.toastMessage(result["message"]);
  //     print(result);
  //     print("hello");
  //     Get.toNamed(PageRoutes.homePage);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TrimeAppBarWithTitle(context, true)
            .getAppBarWithBackArrowTitle("Create Meeting", onBack: () {
          Get.back();
        }),
        body: ListView(
          children: [
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: const Text(
                "Meeting Description",
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
                controller: Description,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: InputBorder.none,
                    hintText: "Please Enter Meeting Description"),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: const Text(
                "Date",
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
            SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: const Text(
                "Time",
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
                controller: TimeDetail,
                readOnly: true,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _selectTime(context);
                          });
                        },
                        icon: Image.asset("Assets/Image/schedule.png")),
                    contentPadding: EdgeInsets.only(left: 20, top: 12),
                    border: InputBorder.none,
                    hintText: "11:33"),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: const Text(
                "Duration",
                style: TextStyles.blackSimpleContent,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColors.lightWhiteOpacityColor,
              ),
              child: DropdownButton(
                isExpanded: true,
                underline: const SizedBox(),
                alignment: Alignment.center,
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items
                    .map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                        ),
                      );
                    })
                    .toSet()
                    .toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: const Text(
                "Recurring",
                style: TextStyles.blackSimpleContent,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColors.lightWhiteOpacityColor,
              ),
              child: DropdownButton(
                isExpanded: true,
                underline: const SizedBox(),
                alignment: Alignment.center,
                // Initial Value
                value: dropdownvalue1,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: list
                    .map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                        ),
                      );
                    })
                    .toSet()
                    .toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue1 = newValue!;
                  });
                },
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: const Text(
                "Add More Details",
                style: TextStyles.blackSimpleContent,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Text("Linked Meetings/Tags",
                  style: TextStyle(color: Color(0xffAFAFAF), fontSize: 18)),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Get.toNamed(PageRoutes.AddTags);
              },
            ),
            // SizedBox(height: 10),
            ListTile(
              subtitle: TextField(
                readOnly: true,
                controller: Participant,
                decoration: InputDecoration(border: InputBorder.none),
              ),
              leading: Text("Participant & Watchers",
                  style: TextStyle(color: Color(0xffAFAFAF), fontSize: 18)),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Get.toNamed(PageRoutes.participant);
              },
            ),
            // SizedBox(height: 10),
            ListTile(
              subtitle: TextField(readOnly: true,
                controller: conference,
                decoration: InputDecoration(border: InputBorder.none),
              ),
              leading: Text("Conferencing",
                  style: TextStyle(color: Color(0xffAFAFAF), fontSize: 18)),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Get.toNamed(PageRoutes.conference);
              },
            ),
            ListTile(
              leading: Container(
                  // margin: EdgeInsets.only(top: 18),
                  child: Text("Venue Details",
                      style:
                          TextStyle(color: Color(0xffAFAFAF), fontSize: 18))),
              title: TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, top: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "Location Paste here"),
              ),
            ),
            ListTile(
              leading: Text("Agenda",
                  style: TextStyle(color: Color(0xffAFAFAF), fontSize: 18)),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Get.toNamed(PageRoutes.agenda);
              },
            ),
            ListTile(
              leading: Text("Attachment",
                  style: TextStyle(color: Color(0xffAFAFAF), fontSize: 18)),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Get.toNamed(PageRoutes.attachment);
              },
            ),
            SizedBox(height: 20),
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
                    onPressed: () {},
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
                      // CreateMeeting();
                    },
                    child: Text(
                      "Save",
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

//Participant class
class participant {
  var members = [String];
  var watchers = [String];
  participant({required this.members, required this.watchers});
}
