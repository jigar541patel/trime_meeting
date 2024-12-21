import 'package:Trime/Helper/ApiManager/Modals/meeting/MeetingResponse.dart';
import 'package:Trime/Helper/Utils/SizeConfig.dart';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Helper/ApiManager/ApiManager.dart';
import '../Helper/ApiManager/Modals/meeting/meetingModal.dart';
import '../Helper/ApiManager/Url.dart';
import '../Helper/Utils/common_utils.dart';
import '../Helper/style/styles.dart';
import 'Meetingdetails.dart';

class upcomingsmetting extends StatefulWidget {
  const upcomingsmetting({Key? key}) : super(key: key);

  @override
  State<upcomingsmetting> createState() => _upcomingsmettingState();
}

class _upcomingsmettingState extends State<upcomingsmetting> {
// ignore: unused_field
  bool _StarthasBeenPressed = false;
  var elements = [];
  var date = [];
  String description = "";
  int duration = 0;
  String recurring = "";
  String time = "";
  dynamic Images = [];
  bool indicator = true;
  dynamic img;
  double cardSpace = 2;
  int index = 0;
  var day = "";
  int dayInt = 0;
  dynamic confrence;
  String? selectedValue;
  List<String> participantsArray = <String>[];
  dynamic userId;
  late MeetingModal? result;
  dynamic confrences;

  @override
  void initState() {
    super.initState();
    // var owherId = await sharePrefrence.getString("owherId");

    setState(() {
      Meeting().whenComplete(() => setState(() {}));
    });
  }

  RemoveMeeting(String meetingid) async {
    Map parameter = {"meeting_id": meetingid};
    var result = await ApiManager.deleteMeeting(parameter);

    if (result["status"]) {
      setState(() {
        elements.removeWhere((element) => element.id == meetingid);
      });
      indicator = false;
      setState(() {
        Navigator.pop(context);
      });
      CommonUtils.toastMessage(result["message"]);
    } else {
      CommonUtils.toastMessage(result["message"]);
      indicator = false;
    }
  }

  MeetingComplete(String meetingid) async {
    var result = await ApiManager.GetMeetingComplete(meetingid);

    if (result["status"]) {
      setState(() {
        elements.removeWhere((element) => element.id == meetingid);
      });
      setState(() {
        // Meeting().whenComplete(() => setState(() {}));
        Navigator.pop(context);
      });
      CommonUtils.toastMessage(result["message"]);
    } else {
      CommonUtils.toastMessage(result["message"]);
    }
  }

  Meeting() async {
    userId = await sharePrefrence.getString("userId");
    var now = new DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    var currentDate = formatter.format(now);
    Map parameter = {"date": currentDate};
    result = await ApiManager.GetMeetingUpcoming(parameter);

    debugPrint(
        "trime the request parameter.toString() " + parameter.toString());
    // debugPrint("trime the respponse result!.response[1].description is " +
    //     result!.response[1].description);
    // debugPrint("trime the respponse result!.response[2].description is " +
    //     result!.response[2].description);
    if (result?.status ?? false) {
      indicator = false;
      // elements = result!.response;
      Map<String, dynamic> elementsMap =
          groupBy(result!.response, (MeetingResponse p0) => p0.date);
      elementsMap.forEach(
        (key, value) {
          elementsMap[key].sort((a, b) {
            var timeA = (a.time).replaceAll(":", "");
            var timeB = (b.time).replaceAll(":", "");
            return int.parse(timeA) - int.parse(timeB);
          });
        },
      );
      elements.clear();
      elementsMap.forEach((key, value) {
        elements.addAll(value);
      });

      for (int i = 0; i < result!.response.length; i++) {
        // var Time = await DateFormat('dd MMM,yyyy')
        //     .format(DateTime.parse(result!.response[i].date));

        debugPrint("trime the response result!.response[" +
            i.toString() +
            "].description is " +
            result!.response[index].description);
        debugPrint("trime the response result!.response[" +
            i.toString() +
            "].time is " +
            result!.response[index].time);

        var dateTime = DateTime.parse(elements[index].date);
        var userdate =
            "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
        if (currentDate == userdate) {
          elements[index].days = "Today's Meeting";
        } else {
          elements[index].days = "Upcoming Meeting";
        }
        for (int j = 0; j < result!.response[i].participants.length; j++) {
          String images = result!.response[i].participants[j].image ?? "";
          var values = images.substring(0, 4);
          if (values != "http") {
            var ownerImage = Url.ImageUrl + images;
            elements[i].participants[j].image = ownerImage;
            participantsArray.add(elements[i].participants[j].image);
          } else {
            Images.add(Image.network(images));
          }
        }
        index++;
      }
    } else {
      CommonUtils.toastMessage("");
      indicator = false;
    }
  }

  dynamic setItemCount(int count) {
    var setCount = 0;
    if (count >= 3) {
      setCount = 3;
    } else if (count == 2) {
      setCount = 2;
    } else {
      setCount = 1;
    }
    return setCount;
  }

  void _showDialog(dynamic id) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // StatefulBuilder
          builder: (context, setState) {
            return AlertDialog(
              actions: <Widget>[
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Are you sure you wan't to delete?",
                      style: TextStyles.size16blackRegular,
                    ),
                    //SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.white,
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.blue,
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(fontSize: 20),
                              ),
                            )),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: TextButton(
                              onPressed: () {
                                RemoveMeeting(id);
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.blue,
                              ),
                              child: Center(
                                child: Text(
                                  'Ok',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ))
              ],
            );
          },
        );
      },
    );
  }

  dynamic getTimeString(int value) {
    dynamic time;
    int hour = value ~/ 60;
    int minutes = value % 60;

    if (hour == 0) {
      time = '${minutes.toString() + " min"}';
    } else {
      if (minutes == 0) {
        time = '${hour.toString() + " Hour"}';
      } else {
        time = '${hour.toString()}:${minutes.toString() + " Hour"}';
      }
    }

    return time;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: indicator == false
            ? elements.length > 0
                ? ListView.builder(
                    itemCount: elements.length,
                    itemBuilder: (_, index) {
                      bool isSameDate = true;
                      final String dateString = elements[index].date;
                      final DateTime date = DateTime.parse(dateString);
                      final item = elements[index];
                      if (index == 0) {
                        isSameDate = false;
                      } else {
                        final String prevDateString = elements[index - 1].date;
                        final DateTime prevDate =
                            DateTime.parse(prevDateString);
                        isSameDate = date.isSameDate(prevDate);
                      }
                      if (index == 0 || !(isSameDate)) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 15, top: 5),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    date.formatDate(),
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical! * 2.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black38),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(left: 15, top: 5),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    elements[index].days ?? "",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical! * 2.4,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  )),
                              Card(
                                  elevation: 8.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 6.0),
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 6.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Wrap(children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.65,
                                                  margin: const EdgeInsets.only(
                                                      left: 10.0, top: 10.0),
                                                  child: Text(
                                                    elements[index]
                                                            .description ??
                                                        "",
                                                    //maxLines: 2,
                                                    // overflow: TextOverflow.ellipsis,
                                                    // SizeConfig.blockSizeVertical!*7.5,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "inter,SemiBold",
                                                        fontSize: SizeConfig
                                                                .blockSizeVertical! *
                                                            2.0,
                                                        color:
                                                            Color(0xFF252629)),
                                                  ),
                                                )
                                              ]),
                                              // SizedBox(
                                              //   width: 300,
                                              // ),
                                              elements[index].owner_id.id ==
                                                      userId
                                                  ? PopupMenuButton(
                                                      iconSize: SizeConfig
                                                              .blockSizeVertical! *
                                                          3.5,
                                                      itemBuilder:
                                                          (context) => [
                                                                PopupMenuItem(
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          setState(
                                                                              () {
                                                                            MeetingComplete(elements[index].id);
                                                                          });
                                                                        },
                                                                        child: Text("Mark As Completed"))),
                                                                PopupMenuItem(
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          setState(
                                                                              () {
                                                                            Navigator.pop(context);
                                                                            _showDialog(elements[index].id);
                                                                          });
                                                                        },
                                                                        child: Text("Delete Meeting")))
                                                              ])
                                                  : SizedBox()
                                            ],
                                          )),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0, top: 5.0),
                                        child: Row(
                                          children: [
                                            // Image.asset(
                                            //     "Assets/Image/schedule.png"),
                                            Text(
                                              elements[index].reccuring +
                                                      " ${elements[index].time}" +
                                                      " (" +
                                                      " ${getTimeString(elements[index].duration)}" +
                                                      " )" ??
                                                  "",
                                              style: TextStyle(
                                                  fontFamily: "inter,light",
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical! *
                                                      1.8,
                                                  color: Color(0xFF000000)),
                                            ),

                                            // var value = "${result!.response[i].time}" +
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                              height: SizeConfig
                                                      .blockSizeVertical! *
                                                  4.3,
                                              width: SizeConfig
                                                      .blockSizeVertical! *
                                                  8.5,
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(SizeConfig
                                                          .blockSizeVertical! *
                                                          1.0),
                                                  color: Colors.blue),
                                              child: elements[index]
                                                          .owner_id
                                                          .id ==
                                                      userId
                                                  ? TextButton(
                                                      child: Text(
                                                        "Attend",
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeVertical! *
                                                                1.8,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _StarthasBeenPressed =
                                                              !_StarthasBeenPressed;

                                                          Get.to(
                                                              MeetingDetailsPage(
                                                            id: elements[index]
                                                                    .id ??
                                                                "",
                                                          ));
                                                        });
                                                      },
                                                    )
                                                  : TextButton(
                                                      child: Text(
                                                        "Join",
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeVertical! *
                                                                1.8,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _StarthasBeenPressed =
                                                              !_StarthasBeenPressed;

                                                          Get.to(
                                                              MeetingDetailsPage(
                                                            id: elements[index]
                                                                    .id ??
                                                                "",
                                                          ));
                                                        });
                                                      },
                                                    )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ))
                            ]);
                      } else {
                        return Card(
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 6.0),
                            child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 6.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            margin: const EdgeInsets.only(
                                                left: 10.0, top: 10.0),
                                            child: Text(
                                              elements[index].description ?? "",
                                              //maxLines: 2,
                                              // overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontFamily: "inter,SemiBold",
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical! *
                                                      2.0,
                                                  color: Color(0xFF252629)),
                                            ),
                                          )
                                        ]),
                                        // SizedBox(
                                        //   width: 290,
                                        // ),
                                        elements[index].owner_id.id == userId
                                            ? PopupMenuButton(
                                                iconSize: SizeConfig
                                                        .blockSizeVertical! *
                                                    3.5,
                                                itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                          child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  MeetingComplete(
                                                                      elements[
                                                                              index]
                                                                          .id);
                                                                });
                                                              },
                                                              child: Text(
                                                                  "Mark As Completed"))),
                                                      PopupMenuItem(
                                                          child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  Navigator.pop(
                                                                      context);
                                                                  _showDialog(
                                                                      elements[
                                                                              index]
                                                                          .id);
                                                                });
                                                              },
                                                              child: Text(
                                                                  "Delete Meeting")))
                                                    ])
                                            : SizedBox()
                                      ],
                                    )),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, top: 5.0),
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //     "Assets/Image/schedule.png"),
                                      Text(
                                          elements[index].reccuring +
                                                  " ${elements[index].time}" +
                                                  " (" +
                                                  " ${getTimeString(elements[index].duration)}" +
                                                  " )" ??
                                              "",
                                          style: TextStyle(
                                              fontFamily: "inter,light",
                                              fontSize: SizeConfig
                                                      .blockSizeVertical! *
                                                  1.8,
                                              color: Color(0xFF000000))),

                                      // var value = "${result!.response[i].time}" +
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height:
                                          SizeConfig.blockSizeVertical! * 4.3,
                                      width:
                                          SizeConfig.blockSizeVertical! * 8.5,
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            SizeConfig.blockSizeVertical! * 1.0,
                                          ),
                                          color: Colors.blue),
                                      child: elements[index].owner_id.id ==
                                              userId
                                          ? TextButton(
                                              child: Text(
                                                "Attend",
                                                style: TextStyle(
                                                    // fontSize: 15,
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical! *
                                                        1.8,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _StarthasBeenPressed =
                                                      !_StarthasBeenPressed;

                                                  Get.to(MeetingDetailsPage(
                                                    id: elements[index].id ??
                                                        "",
                                                  ));
                                                });
                                              },
                                            )
                                          : TextButton(
                                              child: Text(
                                                "Join",
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical! *
                                                        1.8,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _StarthasBeenPressed =
                                                      !_StarthasBeenPressed;

                                                  Get.to(MeetingDetailsPage(
                                                    id: elements[index].id ??
                                                        "",
                                                  ));
                                                });
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ));
                      }
                    })
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 200,
                            width: 200,
                            child: Image.asset("Assets/Image/emptytask.png")),
                        SizedBox(height: 10),
                        Center(
                          child: Text("No Meetings Available",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical! * 2.8,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

const String dateFormatter = 'dd MMMM, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
