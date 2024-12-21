import 'package:Trime/Home/upcomingsmetting.dart';
import 'package:flutter/material.dart';

import 'completesmettings.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({Key? key}) : super(key: key);

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  

  @override
  Widget build(BuildContext context) {
    return 
    DefaultTabController(
      length: 2,
      child: Scaffold(
       appBar: AppBar(
        titleSpacing: 0,
            elevation: 0.0,
            backgroundColor: Color.fromRGBO(245, 245, 245, 0.2),
            automaticallyImplyLeading: false,
            flexibleSpace:  TabBar(
                unselectedLabelStyle: TextStyle(backgroundColor: null),
                labelColor: Colors.blue[400],
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab( 
                    text: "Upcoming",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                ]),
          ),
        body:TabBarView(children: [
          upcomingsmetting(),
          completesmettings(),
        ],)
      ),
    );
  }
}
