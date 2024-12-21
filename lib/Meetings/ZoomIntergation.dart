import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:Trime/webpages/Help.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZoomIntergationPage extends StatefulWidget {
  const ZoomIntergationPage({Key? key}) : super(key: key);

  @override
  State<ZoomIntergationPage> createState() => _ZoomIntergationPageState();
}

class _ZoomIntergationPageState extends State<ZoomIntergationPage> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: TrimeAppBarWithTitle(context, true)
              .getAppBarWithBackArrowTitle("Zoom Integration", onBack: () {
            Get.back();
          }),
          body: ListView(children: [
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "Zoom Email*",
                style: TextStyles.blackSimpleContent,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColors.lightWhiteOpacityColor,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: InputBorder.none,
                    hintText: "Enter your email id"),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "Zoom API Key*",
                style: TextStyles.blackSimpleContent,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColors.lightWhiteOpacityColor,
              ),
              child: TextFormField(
                obscureText: obscure,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: InputBorder.none,
                    hintText: "Enter your Password"),
              ),
            ),
            SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "Zoom API Secret*",
                style: TextStyles.blackSimpleContent,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColors.lightWhiteOpacityColor,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: InputBorder.none,
                    hintText: "Zoom API secret"),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.bottomRight,
              // width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () {
                  Get.to(HelpPage(
                    url: "http://3.108.40.59/faq/",
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset("Assets/Image/help.png",
                        height: 30,
                        width: 30,
                        color: Colors.blue,
                        fit: BoxFit.fill),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
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
                    onPressed: () {},
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
          ])),
    );
  }
}
