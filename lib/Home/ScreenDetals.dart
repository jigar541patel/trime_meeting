import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/bottom_bar/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScreenDetailsPage extends StatefulWidget {
  const ScreenDetailsPage({Key? key}) : super(key: key);

  @override
  State<ScreenDetailsPage> createState() => _ScreenDetailsPage();
}
class _ScreenDetailsPage extends State<ScreenDetailsPage> {
  int pageIndex = 0;
  IconData? _selectedIcon;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.toNamed(PageRoutes.meetingpage);
            },
            icon: Image.asset(
              "Assets/Image/Arrow_left.png",
              color: Colors.white,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.zero,
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Image.asset("Assets/Image/Headphone.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 90),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (MediaQuery.of(context).orientation ==
                              Orientation.landscape) {
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.portraitDown,
                              DeviceOrientation.portraitUp
                            ]);
                          } else {
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.landscapeLeft,
                              DeviceOrientation.landscapeRight,
                            ]);
                          }
                        });
                      },
                      icon: Image.asset("Assets/Image/screenrotate.png"),
                    ),
                  ),
                  Container(
                    // alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 9),
                    child: Image.asset("Assets/Image/zoom.png"),
                  ),
                  Container(
                      // alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 90),
                      child: Text(
                        "Zoom",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )),
                  Container(
                      decoration: BoxDecoration(color: Color(0xffF44336)),
                      // alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "End",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              child: Image.asset(
                "Assets/Image/it.png",
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBarWidget(),
      ),
    );
  }
}
