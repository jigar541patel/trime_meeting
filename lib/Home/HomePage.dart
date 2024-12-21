import 'dart:io';

import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Home/Meeting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: WillPopScope(
        onWillPop: () async {
          exit(0);
        },
        child: SafeArea(child: 
        Scaffold(
          appBar: 
          AppBar(
            titleSpacing: 0,
            elevation: 0.0,
            // backgroundColor: Color.fromRGBO(245, 245, 245, 0.2),
            automaticallyImplyLeading: false,
            title: const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  //borderRadius: BorderRadius.all(Radius.circular(0)),
                  color: Colors.blue,
                ),
                unselectedLabelStyle: TextStyle(backgroundColor: null),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: "Meeting",
                  ),
                  // Tab(
                  //   text: "Tasks",
                  // )
                  // Tab(
                  //   text: "Dashboard",
                  // )
                ]),
          ),
          body: TabBarView(children: [
            MeetingPage(),
            //TasksPage()
            // DashboardPage(),
          ]),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(PageRoutes.homePage);
                },
                icon: Image.asset(
                  "Assets/Image/homeTab.png",
                  color: Colors.blue,
                ),
                iconSize: 40,
              ),
              SizedBox(
                width: 50,
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed(PageRoutes.profilePage);
                },
                icon: Image.asset("Assets/Image/Setting-new.png"),
                iconSize: 55,
              )
            ],
          ),
        ),)
      ),
    );
  }
}
