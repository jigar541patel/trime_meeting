import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/PageRoute.dart';
import '../Helper/Utils/SizeConfig.dart';
import '../Helper/style/styles.dart';

class Intropages extends StatefulWidget {
  Intropages({Key? key}) : super(key: key);

  @override
  State<Intropages> createState() => _IntropagesState();
}

class _IntropagesState extends State<Intropages> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top:    SizeConfig.blockSizeVertical!*6.0, bottom: 10, right: 60, left: 60),
              child: Image.asset(
                "Assets/Image/logo_tm.png",
              )),
          Container(
              alignment: Alignment.center,
              //margin: EdgeInsets.only(top: 10,left: 75,right: 75),
              child: Text("The new-normal work platfrom")),
          // SizedBox(height: 30,),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 4.0,
          ),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 25, right: 25),
              child: Image.asset("Assets/Image/IntoIMages.jpeg")),
          // SizedBox(
          //   height: 60,
          // ),
          SizedBox(height: SizeConfig.blockSizeVertical!*7.0,),
          Container(
              alignment: Alignment.center,
              // margin: EdgeInsets.only(top: 55,left: 65,right: 65),
              child: Text(
                "MEETINGS,NOTES,  TASKS,DOCS-All",
                textAlign: TextAlign.center,
                maxLines: 2,
                // style: TextStyles.titleTextStyles,
                style: TextStyle(
                    fontFamily: "inter,medium",
                    fontSize: SizeConfig.blockSizeVertical!*3.8,
                    color: Color(0xFF252629)
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.center,
              //margin: EdgeInsets.only(top: 55,left: 65,right: 65),
              child: Text(
                "Connected ,All Managed from one place",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: "inter,medium",
                    fontSize: SizeConfig.blockSizeVertical!*3.5,
                    color: Color(0xFF252629)
                ),
                // style: TextStyles.destitleTextStyles,
              )),

          // SizedBox(
          //   height: 40,
          // ),
          SizedBox(height: SizeConfig.blockSizeVertical!*4.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 20,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text("Version 1.0",
                      style: TextStyles.decriptionTextStyles)),
              // const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  Get.toNamed(PageRoutes.loginPage);
                },
                icon: Image.asset("Assets/Image/forward.png"),
                iconSize: 52,
              )
            ],
          ),
        ],
      )),
    );
  }
}
