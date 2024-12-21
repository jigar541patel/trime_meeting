import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssistPage extends StatefulWidget {
  const AssistPage({ Key? key }) : super(key: key);

  @override
  State<AssistPage> createState() => _AssistPageState();
}

class _AssistPageState extends State<AssistPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         appBar: TrimeAppBarWithTitle(context, true)
            .getAppBarWithBackArrowTitle("Add Assist", onBack: () {
          Get.back();
        }),
        body: ListView(
          children: [
            const SizedBox(height: 50),
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
                    hintText: "Assist To"),
              ),
            ),
            ]  ),
      
     ) );
  }
}