import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConferencingPage extends StatefulWidget {
  const ConferencingPage({Key? key}) : super(key: key);

  @override
  State<ConferencingPage> createState() => _ConferencingPageState();
}

class _ConferencingPageState extends State<ConferencingPage> {
  bool _ZoomhasBeenPressed = false;
  bool _TrimehasBeenPressed = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: TrimeAppBarWithTitle(context, true)
          .getAppBarWithBackArrowTitle("Add Conferencing", onBack: () {
        Get.back();
      }),
      body: ListView(children: [
        const SizedBox(height: 50),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: const Text(
            "Choose",
            style: TextStyles.blackSimpleContent,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color:
                      _ZoomhasBeenPressed ? Color(0xff5fcdd6) : Colors.white10,
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(15)),
              // margin: const EdgeInsets.only(left: 3, right: 3),
              height: 40,

              // width: MediaQuery.of(context).size.width,
              child: TextButton(
                // color: _hasBeenPressed ? Color(0xff5fcdd6) :Colors.white10,
                onPressed: () {
                  setState(() {
                    _ZoomhasBeenPressed = !_ZoomhasBeenPressed;
                    Get.toNamed(PageRoutes.ZoomIntergration);
                  });
                },
                child: Row(
                  children: [
                    Image.asset(
                      "Assets/Image/zoomIcon.png",
                      height: 20,
                      width: 20,
                    ),
                    Text(
                      "Zoom",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: "inter,SemiBold"),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color:
                      _TrimehasBeenPressed ? Color(0xff5fcdd6) : Colors.white10,
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(
                left: 20,
              ),
              height: 40,

              // width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _TrimehasBeenPressed = !_TrimehasBeenPressed;
                  });
                },
                child: Row(
                  children: [
                    Image.asset(
                      "Assets/Image/trimeIcon.png",
                      height: 20,
                      width: 20,
                    ),
                    Text(
                      "Trime",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: "inter,SemiBold"),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
      ]),
    ));
  }
}
