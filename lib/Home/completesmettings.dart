import 'package:Trime/Helper/ApiManager/Modals/meeting/MeetingResponse.dart';
import 'package:Trime/Helper/ApiManager/Url.dart';
import 'package:Trime/Helper/Utils/SizeConfig.dart';
import 'package:Trime/Home/upcomingsmetting.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../Helper/ApiManager/ApiManager.dart';
import '../Helper/ApiManager/Modals/meeting/meetingModal.dart';
import '../Helper/PageRoute.dart';
import '../Helper/Utils/common_utils.dart';
import '../Helper/style/styles.dart';
import 'MeetingDetailsNotes.dart';

class completesmettings extends StatefulWidget {
  const completesmettings({Key? key}) : super(key: key);

  @override
  State<completesmettings> createState() => _completesmettingsState();
}

class _completesmettingsState extends State<completesmettings> {
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
  List<String> participantsArray = <String>[];

  late MeetingModal? result;

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  @override
  void initState() {
    super.initState();
    Meeting().whenComplete(() => setState(() {}));
  }

  Meeting() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String currentDate = formatter.format(now);
    Map parameter = {"due_date": currentDate};
    result = await ApiManager.GetMeetingPrevious(parameter);

    if (result!.status) {
      indicator = false;
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

      // elements.addAll(elementsMap.entries);
      // for (int i = 0; i < elementsMap.length; i++) {
      //   for (int j = 0;
      //       j < elementsMap.entries.elementAt(i).value.length;
      //       j++) {
      //     debugPrint("jigar the elementsMap data is 98 : " +
      //         elementsMap.entries.elementAt(i).value[j].description.toString());
      //
      //     // .elementAt(i)
      //     // .value[j];
      //   }
      // }
      // MeetingResponse weightData = MeetingResponse.fromJson(elementsMap.entries);

      debugPrint(
          "jigar the weightData value data is " + elementsMap.toString());

      // elementsMap.forEach((k,v) => print('trime key : ${k}: trime value ${v[9]}'));
      // List<MeetingResponse> weightData =
      // elementsMap.entries.map( (entry) => MeetingResponse(entry.key, entry.value)).toList();

      // debugPrint("jigar the elementMap key data is " +
      //     elementsMap.entries.single.key.toString());
      // debugPrint("jigar the elementMap value data is " +
      //     elementsMap.entries.single.value["date"].toString());

      for (int i = 0; i < result!.response.length; i++) {
        // setState(() async {
        // elements = result!.response;
        // DateTime nowDay = DateTime.parse(data.date);
        // nowDay =nowDay.add(Duration())

        // Map responseMap=result!.response.asMap();
        // final releaseDateMap = responseMap.groupBy((m) => m['date']);

        var Time = await DateFormat('dd MMM,yyyy')
            .format(DateTime.parse(result!.response[i].date));

        var dayInt = await DateFormat('jm')
            .format(DateTime.parse(result!.response[i].date));

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
        // });
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
                                  margin: EdgeInsets.only(left: 15, top: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    date.formatDate(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black38),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(left: 15, top: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Previous Meeting",
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        children: [
                                          Container(
                                            // constraints: BoxConstraints(
                                            //     minWidth: 100,
                                            //     maxWidth: MediaQuery.of(context)
                                            //             .size
                                            //             .width *
                                            //         0.5),
                                            margin: const EdgeInsets.only(
                                                left: 15.0, top: 10.0),
                                            child: Text(
                                                elements[index].description ??
                                                    "",
                                                //maxLines: 2,
                                                // overflow: TextOverflow.ellipsis,

                                                style: TextStyle(
                                                    fontFamily:
                                                        "inter,SemiBold",
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical! *
                                                        2.0,
                                                    color: Color(0xFF252629))),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15.0, top: 10.0),
                                        child: Text(
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
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                // setState(()
                                                // async
                                                {
                                                  _StarthasBeenPressed =
                                                      await !_StarthasBeenPressed;
                                                  Get.to(MeetingDetailsNotes(
                                                    id: elements[index].id ??
                                                        "",
                                                  ));
                                                }
                                                // );
                                                //Get.toNamed(PageRoutes.meetingDetailsNotes);
                                              },
                                              icon: Image.asset(
                                                  "Assets/Image/Forward Outline.png")),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // constraints: BoxConstraints(
                                  //     minWidth: 100,
                                  //     maxWidth: MediaQuery.of(context)
                                  //             .size
                                  //             .width *
                                  //         0.5),
                                  margin: const EdgeInsets.only(
                                      left: 15.0, top: 10.0),
                                  child: Text(
                                    elements[index].description ?? "",
                                    //maxLines: 2,
                                    // overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: "inter,SemiBold",
                                        fontSize:
                                            SizeConfig.blockSizeVertical! * 2.0,
                                        color: Color(0xFF000000)),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 15.0, top: 10.0),
                                  child: Text(
                                    elements[index].reccuring +
                                            " ${elements[index].time}" +
                                            " (" +
                                            " ${getTimeString(elements[index].duration)}" +
                                            " )" ??
                                        "",
                                    style: TextStyle(
                                        fontFamily: "inter,light",
                                        fontSize:
                                            SizeConfig.blockSizeVertical! * 1.8,
                                        color: Color(0xFF000000)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          _StarthasBeenPressed =
                                              !_StarthasBeenPressed;
                                          Get.to(MeetingDetailsNotes(
                                            id: elements[index].id ?? "",
                                          ));
                                          // Get.toNamed(PageRoutes.meetingDetailsNotes);
                                        },
                                        icon: Image.asset(
                                            "Assets/Image/Forward Outline.png")),
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
                            height: 300,
                            width: 300,
                            child: Image.asset("Assets/Image/emptytask.png")),
                        SizedBox(height: 10),
                        Center(
                          child: Text("No Meetings Available",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                      ],
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
