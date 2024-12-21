import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchersPage extends StatefulWidget {
  const WatchersPage({ Key? key }) : super(key: key);

  @override
  State<WatchersPage> createState() => _WatchersPageState();
}

class _WatchersPageState extends State<WatchersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         appBar: TrimeAppBarWithTitle(context, true)
            .getAppBarWithBackArrowTitle("Add Watchers", onBack: () {
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
                    hintText: "Watcher"),
              ),
            ),
            ]  ),
      
     ) );
  }
}