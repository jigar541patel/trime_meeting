import 'package:Trime/Helper/ApiManager/ApiManager.dart';
import 'package:Trime/Helper/ApiManager/Url.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/Utils/SizeConfig.dart';
import 'package:Trime/Helper/Utils/common_utils.dart';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:Trime/Home/JitsiMeeting.dart';
import 'package:Trime/Home/MeetingDetailsNotes.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Helper/ApiManager/Modals/MeetingDetails/PerviousMeetingDetail.dart';
import '../webpages/linkswebview.dart';

class MeetingDetailsPage extends StatefulWidget {
  String id = "";

  MeetingDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<MeetingDetailsPage> createState() => _MeetingDetailsPageState();
}

class _MeetingDetailsPageState extends State<MeetingDetailsPage> {
  late PerviousMeetingDetail? result;
  String date = "";
  String description = "";
  int index = 0;
  dynamic time;
  dynamic dutatsion;
  String totalTime = "";
  dynamic ownerImage;
  dynamic OwnerName;
  dynamic OwnerEmail;
  late bool momsent;
  dynamic participants;
  dynamic owher;
  dynamic watchers;
  dynamic guestparticipants;
  dynamic guestwatchers;
  dynamic contactwatcher;
  dynamic contactparticipant;
  dynamic dates;
  String membersCount = "";
  bool ischecked = true;
  String urlLinks = "";
  String agendaName = "";
  String agendadescriptsion = "";
  String publicNote = "";
  String privateNote = "";
  dynamic doucements;
  dynamic confrence;

  // ignore: deprecated_member_use
  List<String> participantsArray = <String>[];
  List<String> participantsEmailArray = <String>[];
  List<String> emailArray = <String>[];
  List<String> OwneremailArray = <String>[];
  List<String> watchersArray = <String>[];
  List<String> watchersEmailArray = <String>[];
  List<String> agendaArray = <String>[];
  dynamic taskArray;
  dynamic links;
  dynamic fileurl;
  List<bool> StatusArray = <bool>[];
  bool indicator = true;
  dynamic agendas;
  dynamic linkedMeeting;
  String? linkedMeetingdes = "";
  String? linkedMeetingId = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      getMeetingById().whenComplete(() => setState(() {}));
    });
  }

  getMeetingById() async {
    var url = Url.MeetingById + widget.id;

    print('notification url--$url');

    result = await ApiManager.GetPerivousMeetingDetailsById(url);
    //GetPerivousMeetingDetailsById(url);
    print('trime the GetPerivousMeetingDetailsById --' +
        result!.response.toString());

    if (result!.status) {
      indicator = false;
      // for (var Data in result!.response) {
      dynamic owherId = await sharePrefrence.saveString(
          "owherId", result?.response.owner_id.id);

      var image = result?.response.owner_id.image ?? "";
      var value = image.substring(0, 4);

      if (image.isNotEmpty) {
        ownerImage = NetworkImage(Url.ImageUrl + image);
      } else {
        ownerImage = NetworkImage(image);
      }

      participants = result?.response.participants;
      if (participants?.isNotEmpty ?? false) {
        for (int i = 0; i < participants?.length; i++) {
          emailArray.add(participants[i]?.email);
          StatusArray.add(participants[i]?.status);
          if (value != "http") {
            var Image = Url.ImageUrl + participants[i].image;
            participantsArray.add(Image);
            participantsEmailArray.add(participants[i].email);
          } else {}
        }
      } else {
        setState(() {
          OwnerEmail = result?.response.owner_id.email;
          emailArray.add(OwnerEmail);
        });
      }

      watchers = result?.response.watchers;
      if (watchers?.isNotEmpty ?? false) {
        for (int i = 0; i < watchers?.length; i++) {
          var image = watchers[i].image ?? "";
          watchersArray.add(Url.ImageUrl + image);
          watchersEmailArray.add(watchers[i].email);
        }
      }

      // ignore: unused_local_variable
      guestparticipants = result?.response.guestparticipants;
      if (guestparticipants?.isNotEmpty ?? false) {
        for (int i = 0; i < guestparticipants?.length; i++) {
          if (value != "http") {
            var Image = Url.ImageUrl + "default_user.png";
            participantsArray.add(Image);
            participantsEmailArray.add(guestparticipants[i]);
          }
        }
      }
      // ignore: unused_local_variable
      guestwatchers = result?.response.guestwatchers;
      if (guestwatchers?.isNotEmpty ?? false) {
        for (int i = 0; i < guestwatchers?.length; i++) {
          watchersArray.add(Url.ImageUrl + "default_user.png");
          watchersEmailArray.add(guestwatchers[i]);
        }
      }

      contactparticipant = result?.response.contactparticipant;
      if (contactparticipant?.isNotEmpty ?? false) {
        for (int i = 0; i < contactparticipant?.length; i++) {
          if (value != "http") {
            var Image = Url.ImageUrl + "default_user.png";
            participantsArray.add(Image);
            participantsEmailArray.add(contactparticipant[i].email);
          }
        }
      }
      // ignore: unused_local_variable
      contactwatcher = result?.response.contactwatcher;
      if (contactwatcher?.isNotEmpty ?? false) {
        for (int i = 0; i < contactwatcher?.length; i++) {
          watchersArray.add(Url.ImageUrl + "default_user.png");
          watchersEmailArray.add(contactwatcher[i].email);
        }
      }
      agendas = result?.response.agenda;
      links = result?.response.links;
      fileurl = result?.response.documents;
      dates = await DateFormat('dd-MM-yyyy')
          .format(DateTime.parse(result!.response.date));
      linkedMeeting = result?.response.linkedmeeting ?? "";
      for (var i = 0; i < linkedMeeting?.length; i++) {
        if (linkedMeeting != null) {
          var dateTime = DateTime.parse(linkedMeeting[i].date ?? "");

          final DateFormat formatter = DateFormat('dd-MMMM-y');
          String date = formatter.format(dateTime);
          linkedMeetingdes = ((linkedMeeting[i].description)! + (date));
          linkedMeetingId = linkedMeeting[i].id ?? "";
        }
      }
      setState(() {
        var length = participants.length +
            watchers.length +
            guestparticipants.length +
            guestwatchers.length +
            contactparticipant.length +
            contactwatcher.length +
            1;
        membersCount = "Members (" + ' $length ' + ")";
        momsent = result?.response.mom_sent ?? false;
        date = "$dates";
        description = result?.response.description ?? "";
        time = result?.response.time;
        dutatsion = " (" + getTimeString(result!.response.duration) + ")     ";
        confrence = result?.response.conference ?? "";
        var value = time + dutatsion;
        totalTime = value;
        OwnerName = result?.response.owner_id.name;
        OwnerEmail = result?.response.owner_id.email;
        owher = Url.ImageUrl + "${result?.response.owner_id.image}";
        OwneremailArray.add(OwnerEmail);
        taskArray = result?.response.task;
        publicNote = result?.response.note ?? "";
      });
      // }
    } else {
      indicator = false;
      CommonUtils.toastMessage("");
    }
  }

  dynamic getTimeString(int value) {
    dynamic time;
    int hour = value ~/ 60;
    int minutes = value % 60;

    if (hour == 0) {
      time = '${minutes.toString() + " min "}';
    } else {
      if (minutes == 0) {
        time = '${hour.toString() + " Hour "}';
      } else {
        time = '${hour.toString()}:${minutes.toString() + " Hour "}';
      }
    }

    return time;
  }

  dynamic doucementList(dynamic fileUrlArray) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Text(
                  "Documents:",
                  style: TextStyles.cardTextStyles,
                ),
                fileUrlArray.isNotEmpty
                    ? Image.asset("Assets/Image/RightArrow.png")
                    : SizedBox()
              ],
            )),
        fileUrlArray.isNotEmpty
            ? Container(
                width: MediaQuery.of(context).size.width * 0.63,
                //margin: EdgeInsets.only(right: 5),
                height: 55,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var i = 0; i < fileUrlArray.length; i++)
                      Container(
                        //MediaQuery.of(context).size.height,
                        margin: EdgeInsets.all(10),
                        child: DottedBorder(
                            color: Colors.blue,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(30),
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    margin: EdgeInsets.only(left: 5, right: 5),
                                    child: Text(
                                      fileUrlArray[i],
                                      style: TextStyles.blueButtonLinkTextStyle,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  InkWell(
                                      onTap: (() async {
                                        Map<Permission, PermissionStatus>
                                            statuses = await [
                                          Permission.storage,
                                          //add more permission to request here.
                                        ].request();
                                        if (statuses[Permission.storage]!
                                            .isGranted) {
                                          var dir = await DownloadsPathProvider
                                              .downloadsDirectory;
                                          if (dir != null) {
                                            String savename = DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString();
                                            // String strFileName= DateTime.now().millisecond;
                                            // String savename =
                                            //     "${Url.fileurl}${fileUrlArray[i]}";
                                            //   String savename ="tempfile.pdf";
                                            String savePath =
                                                dir.path + "/$savename";
                                            print(savePath);

                                            //output:  /storage/emulated/0/Download/banner.png

                                            try {
                                              await Dio().download(
                                                  "${Url.fileurl}${fileUrlArray[i]}",
                                                  savePath, onReceiveProgress:
                                                      (received, total) {
                                                if (total != -1) {
                                                  print((received / total * 100)
                                                          .toStringAsFixed(0) +
                                                      "%");
                                                  //you can build progressbar feature too
                                                }
                                              });
                                              print(
                                                  "File is saved to download folder.");
                                              CommonUtils.toastMessage(
                                                  "File Downloaded successfully to : " +
                                                      savePath);
                                            } on DioError catch (e) {
                                              print(e.message);
                                            }
                                          }
                                        } else {
                                          print(
                                              "No permission to read and write.");
                                        }
                                      }),
                                      child: Image.asset(
                                        "Assets/Image/download.png",
                                        color: Colors.blue,
                                      ))
                                ])),
                      ),
                  ],
                ),
              )
            : SizedBox()
      ],
    );
  }

  dynamic LinktList(dynamic linkUrlArray) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          margin: EdgeInsets.only(left: 10.0, top: 8),
          child: Row(
            children: [
              Text(
                "Links:",
                style: TextStyles.cardTextStyles,
              ),
              linkUrlArray.isNotEmpty
                  ? Image.asset("Assets/Image/RightArrow.png")
                  : SizedBox()
            ],
          )),
      linkUrlArray.isNotEmpty
          ? Container(
              width: MediaQuery.of(context).size.width * 0.63,
              //margin: EdgeInsets.only(right: 5),
              height: 55,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                for (var i = 0; i < linkUrlArray.length; i++)
                  Container(
                    margin: EdgeInsets.all(10),
                    child: DottedBorder(
                        color: Colors.blue,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(30),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                linkUrlArray[i],
                                style: TextStyles.blueButtonLinkTextStyle,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(linkswebview(
                                  url: linkUrlArray[i],
                                  isLogin: '',
                                ));
                              },
                              child: Image.asset(
                                "Assets/Image/export.png",
                                color: Colors.blue,
                              ),
                            )
                          ],
                        )),
                  ),
              ]),
            )
          : SizedBox()
    ]);
  }

  void _showOwherDialog(dynamic OwherName) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // StatefulBuilder
          builder: (context, setState) {
            return AlertDialog(
              actions: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Image.asset(
                                    "Assets/Image/cros.png",
                                    fit: BoxFit.fill,
                                  ),
                                  iconSize: 50,
                                ),
                              )
                            ]),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: ownerImage // <--- .image added here
                                    ))),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          // margin: EdgeInsets.only(left: 40 ,top: 10),
                          child: Center(
                            child: Text(
                              OwnerName,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
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

  void _showParicipaintDialog(dynamic watchersImage, dynamic watchersName) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // StatefulBuilder
          builder: (context, setState) {
            return AlertDialog(
              actions: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 30),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Stack(children: <Widget>[
                      ListView(
                        scrollDirection: Axis.horizontal,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (int i = 0; i < watchersImage.length; i++)
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              //         width: MediaQuery.of(context).size.width,
                              // height: MediaQuery.of(context).size.height * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    margin: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 15,
                                        bottom: 10),
                                    // height: 150,
                                    // width: 150,
                                    child: Image.network(
                                      watchersImage[i],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.only(left: 40 ,top: 10),
                                    child: Center(
                                      child: Text(
                                        watchersName[i],
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          // for (int i = 0; i < watchersImage.length; i++)
                          //   Container(
                          //     margin:
                          //         EdgeInsets.only(left: 15, right: 15, top: 25),
                          //     // height: 150,
                          //     // width: 150,
                          //     child: Image.network(
                          //       watchersImage[i],
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),

                          // for (int i = 0; i < watchersName.length; i++)
                          // Container(
                          //   // margin: EdgeInsets.only(left: 40 ,top: 10),
                          //   child: Center(
                          //     child: Text(
                          //       watchersName[i],
                          //       style: TextStyle(
                          //           fontSize: 20, color: Colors.black),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            //margin: EdgeInsets.only(left: 80),
                            width: 40,
                            height: 40,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Image.asset(
                                "Assets/Image/cros.png",
                                fit: BoxFit.fill,
                              ),
                              iconSize: 50,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ]))
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Get.toNamed(PageRoutes.homePage);
              },
              icon: Image.asset("Assets/Image/Arrow_left.png"),
            ),
            title: Column(
              children: [
                SizedBox(height: 15),
                Text("Meeting Details", style: TextStyles.size18Medium),
                SizedBox(height: 10),
                // Text("ONGOING MEETING", style: TextStyles.size16brownRegular)
              ],
            ),
          ),
          body: indicator == false
              ? result?.response.id.isNotEmpty ?? false
                  ? ListView(
                      children: [
                        PreferredSize(
                            preferredSize: Size.zero,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (result?.response.conference
                                            ?.jitsiMeeting?.isNotEmpty ??
                                        false) {
                                      String roomId =
                                          "${result?.response.conference?.jitsiMeeting ?? ""}";
                                      String ownerId =
                                          result?.response.owner_id.id ?? "";
                                      Get.to(Meeting(
                                        roomId: roomId,
                                        ownerId: ownerId,
                                        meetingName: description,
                                        meetingId: widget.id,
                                        conference: result?.response.conference,
                                      ));
                                    } else {
                                      CommonUtils.toastMessage(
                                          "Confrence Not Available");
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 15, right: 15, top: 25),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffE8E8E8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 30,
                                        ),
                                        const Text("Trime",
                                            style: TextStyle(
                                                fontFamily: "inter,SemiBold",
                                                fontSize: 18,
                                                color: Color(0xFF4385F5))),

                                        IconButton(
                                          onPressed: () {
                                            if (result
                                                    ?.response
                                                    .conference
                                                    ?.jitsiMeeting
                                                    ?.isNotEmpty ??
                                                false) {
                                              String roomId =
                                                  "${result?.response.conference?.jitsiMeeting ?? ""}";
                                              String ownerId = result
                                                      ?.response.owner_id.id ??
                                                  "";
                                              Get.to(Meeting(
                                                roomId: roomId,
                                                ownerId: ownerId,
                                                meetingId: widget.id,
                                                meetingName: description,
                                                conference:
                                                    result?.response.conference,
                                              ));
                                            } else {
                                              CommonUtils.toastMessage(
                                                  "Confrence Not Available");
                                            }
                                          },
                                          icon: Image.asset(
                                              "Assets/Image/Tilt.png"),
                                        ),
                                        //  Image.asset("Assets/Image/Tilt.png"),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                            elevation: 8.0,
                            color: Color(0xffE8E8E8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 25.0, left: 10.0),
                                    child: Text("Meeting Details",
                                        style: TextStyle(
                                            fontFamily: "inter,SemiBold",
                                            fontSize:
                                                SizeConfig.blockSizeVertical! *
                                                    2.4,
                                            color: Color(0xFF4385F5))),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          result?.response.conference != null
                                              ? Container(
                                                  constraints: BoxConstraints(
                                                      minWidth: 20,
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.38),
                                                  margin: const EdgeInsets.only(
                                                      left: 10,
                                                      right: 10.0,
                                                      top: 12),
                                                  child: Text(
                                                    description,
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
                                              : Container(
                                                  constraints: BoxConstraints(
                                                      minWidth: 20,
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.45),
                                                  margin: const EdgeInsets.only(
                                                      left: 10.0, top: 12),
                                                  child: Text(
                                                    description,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "inter,regular",
                                                        fontSize: SizeConfig
                                                                .blockSizeVertical! *
                                                            1.8,
                                                        color:
                                                            Color(0xff797979)),
                                                  ),
                                                ),
                                          result?.response.conference != null
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 12),
                                                  child: result
                                                              ?.response
                                                              .conference!
                                                              .type ==
                                                          "Trime"
                                                      ? Image.asset(
                                                          "Assets/Image/jitsi(1).png",
                                                          height: 15,
                                                          width: 15,
                                                        )
                                                      : Image.asset(
                                                          "Assets/Image/zoom(1).png",
                                                          height: 15,
                                                          width: 15,
                                                        ))
                                              : SizedBox(),
                                          result?.response.conference != null
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5.0, top: 12),
                                                  child: Text(
                                                    result?.response.conference!
                                                            .type ??
                                                        "",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "inter,SemiBold",
                                                        fontSize: SizeConfig
                                                                .blockSizeVertical! *
                                                            2.0,
                                                        color:
                                                            Color(0xFF4385F5)),
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 12.0),
                                        child: Text(totalTime,
                                            style: TextStyle(
                                                fontFamily: "inter,SemiBold",
                                                fontSize: SizeConfig
                                                        .safeBlockVertical! *
                                                    1.8,
                                                color: Color(0xFF252629))),
                                      )
                                    ],
                                  ),
                                  result?.response.conference != null
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          margin: const EdgeInsets.only(
                                              left: 10.0, top: 12),
                                          child: Text(
                                            description,
                                            style: TextStyles.cardTextStyles,
                                          ),
                                        )
                                      : SizedBox(
                                          height: 5,
                                        ),
                                  linkedMeetingdes!.isNotEmpty
                                      ? Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(MeetingDetailsNotes(
                                                    id: linkedMeetingId ?? ""));
                                              },
                                              child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  margin: const EdgeInsets.only(
                                                      top: 12.0, left: 15.0),
                                                  child: Image.asset(
                                                      "Assets/Image/link.png")),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(MeetingDetailsNotes(
                                                    id: linkedMeetingId ?? ""));
                                              },
                                              child: Container(
                                                constraints: BoxConstraints(
                                                    minWidth: 70,
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6),
                                                margin: const EdgeInsets.only(
                                                    top: 12.0, left: 8.0),
                                                child: Text(
                                                  linkedMeetingdes ?? "",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyles
                                                      .blackCardContent,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : SizedBox(),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 15.0, left: 10.0),
                                    child: Text(
                                      membersCount,
                                      style: TextStyle(
                                          fontFamily: "inter,SemiBold",
                                          fontSize:
                                              SizeConfig.safeBlockVertical! *
                                                  2.4,
                                          color: Color(0xFF4385F5)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              "Owner",
                                              style: TextStyle(
                                                  fontFamily: "inter,regular",
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical! *
                                                      2.3,
                                                  color: Color(0xff797979)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _showOwherDialog(OwnerName);
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              margin: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: CircleAvatar(
                                                radius: 70,
                                                backgroundImage: ownerImage,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            child: Text(
                                              "Watchers",
                                              style: TextStyle(
                                                  fontFamily: "inter,regular",
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical! *
                                                      2.3,
                                                  color: Color(0xff797979)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          watchersArray.isNotEmpty
                                              ? InkWell(
                                                  onTap: () {
                                                    _showParicipaintDialog(
                                                        watchersArray,
                                                        watchersEmailArray);
                                                  },
                                                  child: Container(
                                                    child:
                                                        //_showParicipaintDialog
                                                        Center(
                                                      child: FlutterImageStack(
                                                        // backgroundColor: Colors.grey,
                                                        itemBorderColor:
                                                            Colors.blue,
                                                        imageList:
                                                            watchersArray,
                                                        showTotalCount: true,
                                                        totalCount:
                                                            watchersArray
                                                                .length,
                                                        itemRadius: 30,
                                                        itemCount: 3,
                                                      ),
                                                    ),
                                                  ))
                                              : SizedBox(
                                                  height: 30,
                                                ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            child: Text(
                                              "Participants      ",
                                              style: TextStyle(
                                                  fontFamily: "inter,regular",
                                                  fontSize: SizeConfig
                                                          .blockSizeVertical! *
                                                      2.3,
                                                  color: Color(0xff797979)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          participantsArray.isNotEmpty
                                              ? InkWell(
                                                  onTap: () {
                                                    _showParicipaintDialog(
                                                        participantsArray,
                                                        participantsEmailArray);
                                                  },
                                                  child: Container(
                                                    child: Center(
                                                      child: FlutterImageStack(
                                                        // backgroundColor: Colors.grey,
                                                        itemBorderColor:
                                                            Colors.blue,
                                                        imageList:
                                                            participantsArray,
                                                        showTotalCount: true,
                                                        totalCount:
                                                            participantsArray
                                                                .length,
                                                        itemRadius: 30,
                                                        itemCount: 3,
                                                      ),
                                                    ),
                                                  ))
                                              : SizedBox(
                                                  height: 30,
                                                ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 10.0),
                                    child: Text(
                                      "Attachments",
                                      style: TextStyle(
                                          fontFamily: "inter,SemiBold",
                                          fontSize:
                                              SizeConfig.safeBlockVertical! *
                                                  2.4,
                                          color: Color(0xFF4385F5)),
                                    ),
                                  ),
                                  doucementList(fileurl),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  LinktList(links),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ])),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 15, top: 15),
                            //height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffE8E8E8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    //height: 40,
                                    margin: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 10,
                                        bottom: 10),
                                    child: Text("Agenda",
                                        style: TextStyle(
                                            fontFamily: "inter,SemiBold",
                                            fontSize:
                                                SizeConfig.safeBlockVertical! *
                                                    2.4,
                                            color: Color(0xFF4385F5)))),
                                for (var i = 0; i < agendas.length; i++)
                                  ListTile(
                                    title: Container(
                                        margin: EdgeInsets.only(
                                            left: 18, right: 15),
                                        child: Text(agendas[i].name,
                                            style:
                                                TextStyles.blueSimpleContent)),
                                    subtitle: Container(
                                        margin: EdgeInsets.only(
                                            right: 15, left: 12),
                                        child:
                                            Html(data: agendas[i].description)),
                                  )
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  : Center(child: Text("Data not found"))
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
