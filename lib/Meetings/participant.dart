import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParticipantandWatcherpage extends StatefulWidget {
  const ParticipantandWatcherpage({Key? key}) : super(key: key);

  @override
  State<ParticipantandWatcherpage> createState() =>
      _ParticipantandWatcherpageState();
}

class _ParticipantandWatcherpageState extends State<ParticipantandWatcherpage> {
  TextEditingController Participant = TextEditingController();
  TextEditingController Watchers = TextEditingController();


  // Validation() {
  //   if (Participant.text.isEmpty) {
  //     CommonUtils.toastMessage("Participant is Required?");
  //   } else if (!regx.regExp.hasMatch(Participant.text)) {
  //     CommonUtils.toastMessage("Invalid Email!");
  //   } else if (Watchers.text.isEmpty) {
  //     CommonUtils.toastMessage("Watchers is Required?");
  //   } else if (!regx.regExp.hasMatch(Watchers.text)) {
  //     CommonUtils.toastMessage("Invalid Email!");
  //   } else {
  //     Get.back();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: TrimeAppBarWithTitle(context, true).getAppBarWithBackArrowTitle(
          "Add Participants & Watchers", onBack: () {
        // Validation();
         Get.back();
      }),
      body: ListView(children: [
        const SizedBox(height: 50),
        Container(
          margin: const EdgeInsets.only(left: 40),
          child: const Text(
            "Add Participants",
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
            controller: Participant,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 20),
                border: InputBorder.none,
                hintText: "Add Attendee Via Email"),
          ),
        ),
        
        SizedBox(height: 45),
        Container(
          margin: const EdgeInsets.only(left: 40),
          child: const Text(
            "Add Watchers",
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
            controller: Watchers,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 12),
                border: InputBorder.none,
                hintText: "Add Attendee Via Email"),
          ),
        ),
      ]),
    ));
  }
}
