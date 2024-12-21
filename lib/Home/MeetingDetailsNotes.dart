import 'dart:io';

import 'package:Trime/Helper/ApiManager/Modals/MeetingDetails/PerviousMeetingDetail.dart';
import 'package:Trime/Helper/ApiManager/Modals/meeting/agendaModal.dart';
import 'package:Trime/Helper/Utils/SizeConfig.dart';

import 'package:Trime/Helper/Utils/regx.dart';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:Trime/Home/fullScreenVideo.dart';
import 'package:Trime/webpages/linkswebview.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Create Task/CreateTask.dart';
import '../Helper/ApiManager/ApiManager.dart';
import '../Helper/ApiManager/Modals/meeting/agendaNotesModal.dart';
import '../Helper/ApiManager/Url.dart';
import '../Helper/PageRoute.dart';
import '../Helper/Utils/common_utils.dart';
import '../Helper/style/styles.dart';

// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class MeetingDetailsNotes extends StatefulWidget {
  String id = "";

  MeetingDetailsNotes({Key? key, required this.id}) : super(key: key);

  @override
  State<MeetingDetailsNotes> createState() => _MeetingDetailsNotesState();
}

class _MeetingDetailsNotesState extends State<MeetingDetailsNotes> {
  TextEditingController VerifyEmail = TextEditingController();
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
  late bool momsent = false;
  dynamic participants;
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
  String doucements = "";
  bool indicator = true;
  dynamic confrence;
  String? pariticipaintsImage = "";

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
  List<bool> StatusArray = <bool>[];

  List<String> _emaillist = [];
  dynamic fileurl;

  // var singleline;
  List<bool> selected = [];
  List<bool> isSelected = [];
  String? status;
  late List<Agenda>? agendas;
  late List<Agenda>? agendas2;
  dynamic userId;
  dynamic OwnerId;
  late List<agendaNotes>? agendaNote;
  List<String> agendaNameArray = [];
  List<String> agendadesArray = [];

  String recordinglink = "";

  @override
  void initState() {
    super.initState();

    setState(() {
      getPrivateNotes();

      getMeetingById().whenComplete(() => setState(() {}));
    });
  }

  void _showDialog() {
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
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Send Meeting Minutes",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.blue),
                              ),
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
                          height: 5,
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Meeting Members",
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        for (int i = 0; i < emailArray.length; i++)
                          // for (var item in emailArray)
                          CheckboxListTile(
                            value: isSelected[i],
                            title: Text(emailArray[i]),
                            onChanged: (value) {
                              // var indexOf = emailArray.indexOf(item);
                              setState(() {
                                // ischecked = value!;
                                isSelected[i] = value!;
                              });
                            },
                          ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            controller: VerifyEmail,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Email",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                //color: Colors.blue,
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    sendLink();
                                  },
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                  ),
                                  child: Text(
                                    'Send Email',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                                //color: Colors.blue,
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    sendMeetings();
                                  },
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Send Meeting Minutes \n To Members',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
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

  sendLink() async {
    var link = Url.BaseUrl + "trime_meet/" + widget.id;
    Map parameters = {
      "email": VerifyEmail.text,
      "description": description,
      "meeting_id": widget.id,
      "owner_name": OwnerName,
      "date": date,
      "time": time,
      "link": link
    };

    if (VerifyEmail.text.isEmpty) {
      CommonUtils.toastMessage("Enter email");
    } else if (!regx.regExp.hasMatch(VerifyEmail.text)) {
      CommonUtils.toastMessage("Invalid email");
    } else {
      var result1 = await ApiManager.LinkSend(parameters);

      if (result1!["status"]) {
        CommonUtils.toastMessage(result1!["message"]);
        getMeetingById().whenComplete(() => setState(() {}));
        Navigator.pop(context);
      } else {
        CommonUtils.toastMessage(result1.message!);
      }
    }
  }

  sendMeetings() async {
    var link = Url.BaseUrl + "trime_meet/" + widget.id;
    Map parameters = {
      "email": emailArray,
      "description": description,
      "meeting_id": widget.id,
      "owner_name": OwnerName,
      "date": date,
      "time": time,
      "link": link
    };

    var result1 = await ApiManager.LinkSend(parameters);

    if (result1!["status"]) {
      CommonUtils.toastMessage(result1!["message"]);
      getMeetingById().whenComplete(() => setState(() {}));
      Navigator.pop(context);
    } else {
      CommonUtils.toastMessage(result1.message!);
    }
  }

  getMeetingById() async {
    userId = await sharePrefrence.getString("userId");
    var url = Url.MeetingById + widget.id;

    result = await ApiManager.GetPerivousMeetingDetailsById(url);
    //GetPerivousMeetingDetailsById(url);
    if (result!.status) {
      print("abhi");

      // for (var Data in result!.response) {
      dynamic owherId = await sharePrefrence.saveString(
          "owherId", result?.response.owner_id.id);

      String image = result?.response.owner_id.image ?? "";
      var value = image.substring(0, 4);

      if (value != "http") {
        ownerImage = NetworkImage(Url.ImageUrl + image);
      } else {
        ownerImage = NetworkImage(image);
      }
      participants = result?.response.participants;

      if (participants?.isNotEmpty ?? false) {
        for (int i = 0; i < participants?.length; i++) {
          emailArray.add(participants[i]?.email);
          isSelected.add(true);
          StatusArray.add(participants[i]?.status);

          if (participants[i]?.image != null) {
            pariticipaintsImage = Url.ImageUrl + participants[i]!.image;
            participantsArray.add(pariticipaintsImage!);
            participantsEmailArray.add(participants[i]!.email);
          }
        }
      }

      watchers = result?.response.watchers;

      if (watchers?.isNotEmpty ?? false) {
        for (int i = 0; i < watchers?.length; i++) {
          var image = watchers[i].image ?? "";
          watchersArray.add(Url.ImageUrl + image);
          emailArray.add(watchers[i]?.email);
          watchersEmailArray.add(watchers[i]?.email);
          isSelected.add(true);
        }
      }

      guestparticipants = result?.response.guestparticipants;
      if (guestparticipants?.isNotEmpty ?? false) {
        for (int i = 0; i < guestparticipants?.length; i++) {
          if (value != "http") {
            var ownerImage = Url.ImageUrl + "default_user.png";
            participantsArray.add(ownerImage);

            emailArray.add(guestparticipants[i]);
            participantsEmailArray.add(guestparticipants[i]);
            isSelected.add(true);
          }
        }
      }

      // ignore: unused_local_variable
      guestwatchers = result?.response.guestwatchers;
      if (guestwatchers?.isNotEmpty ?? false) {
        for (int i = 0; i < guestwatchers?.length; i++) {
          watchersArray.add(Url.ImageUrl + "default_user.png");
          watchersEmailArray.add(guestwatchers?[i]);
          emailArray.add(guestwatchers[i]);
          isSelected.add(true);
        }
      }

      contactparticipant = result?.response.contactparticipant;
      if (contactparticipant?.isNotEmpty ?? false) {
        for (int i = 0; i < contactparticipant?.length; i++) {
          if (value != "http") {
            var ownerImage = Url.ImageUrl + "default_user.png";
            participantsArray.add(ownerImage);
            emailArray.add(contactparticipant[i].email);
            participantsEmailArray.add(contactparticipant[i].email);

            isSelected.add(true);
          }
        }
      }

      // ignore: unused_local_variable
      contactwatcher = result?.response.contactwatcher;
      if (contactwatcher?.isNotEmpty ?? false) {
        for (int i = 0; i < contactwatcher?.length; i++) {
          watchersArray.add(Url.ImageUrl + "default_user.png");
          emailArray.add(contactwatcher[i].email);
          watchersEmailArray.add(contactwatcher[i].email);
          isSelected.add(true);
        }
      }

      agendaNote = result?.response.agendaNote;

      agendas = result?.response.agenda;

      for (int i = 0; i < agendas!.length; i++) {
        agendaNameArray.add(agendas?[i].name ?? "");
        agendadesArray.add(agendas?[i].description ?? "");
        agendas?[i].name = "${agendas?[i].name ?? ""} (Public)";

        for (var es in agendaNote!) {
          if (es.agenda_id == agendas?[i].id) {
            agendas?[i].description = es.note;
            break;
          } else {
            agendas?[i].description = "";
          }
        }
      }

      links = result?.response.links;

      fileurl = result?.response.documents;
      if (participants == null ||
          watchers == null ||
          guestparticipants == null ||
          guestwatchers == null ||
          contactparticipant == null ||
          contactwatcher == null) {
        setState(() {
          OwnerEmail = result?.response.owner_id.email;
          emailArray.add(OwnerEmail);
          isSelected.add(true);
        });
      } else {
        setState(() {
          OwnerEmail = result?.response.owner_id.email;
          emailArray.add(OwnerEmail);
          isSelected.add(true);
        });
      }

      var link = result?.response.links;
      var agenda = result?.response.agenda;
      var doucement = result?.response.documents;

      dates = await DateFormat('dd-MM-yyyy')
          .format(DateTime.parse(result!.response.date));

      setState(() {
        var length = participants?.length +
            watchers?.length +
            guestparticipants?.length +
            guestwatchers?.length +
            contactparticipant?.length +
            contactwatcher?.length +
            1;
        membersCount = "Members (" + ' $length ' + ")";

        print(watchersArray.length);
        print("ram");
        momsent = result?.response.mom_sent ?? false;
        confrence = result?.response.conference;
        status = result?.response.status;

        date = "$dates";

        description = result?.response.description ?? "";

        time = result?.response.time;

        dutatsion = " (" + getTimeString(result!.response.duration) + ")     ";

        var value = time + dutatsion;
        totalTime = value;
        OwnerName = result?.response.owner_id.name;
        OwnerEmail = result?.response.owner_id.email;
        OwneremailArray.add(OwnerEmail);

        taskArray = result?.response.task;

        publicNote = result?.response.note ?? "";
        recordinglink = result?.response.recordinglink ?? "";
      });
      indicator = false;
      // }
    } else {
      indicator = false;
      //CommonUtils.toastMessage("");
    }
  }

  getPrivateNotes() async {
    var id = await sharePrefrence.getString("userId");

    Map parameter = {"meeting_id": widget.id, "owner_id": id};
    print(parameter);

    var result = await ApiManager.privateNote(parameter);

    if (result!["response"] != null) {
      setState(() {
        privateNote = result["response"]["notes"] ?? "";
      });
    } else {
      //indicator = false;
      // CommonUtils.toastMessage("");
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
                  style: TextStyle(
                      fontFamily: "inter,regular",
                      fontSize: SizeConfig.blockSizeVertical! * 2.2,
                      color: Color(0xff797979)),
                ),
                fileUrlArray.isNotEmpty
                    ? Image.asset("Assets/Image/RightArrow.png")
                    : SizedBox()
              ],
            )),
        fileUrlArray != null
            ? Container(
                width: MediaQuery.of(context).size.width * 0.63,

                //margin: EdgeInsets.only(right: 5),
                height: SizeConfig.blockSizeVertical! * 7.8,
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
                                            String savename =
                                                "${Url.fileurl}${fileUrlArray[i]}";
                                            String savePath =
                                                dir.path + "/$savename";
                                            print(savePath);

                                            //output:  /storage/emulated/0/Download/banner.png

                                            try {
                                              Dio().download(
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
                                                  "File Downloaded successfully");
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
                style: TextStyle(
                    fontFamily: "inter,regular",
                    fontSize: SizeConfig.blockSizeVertical! * 2.2,
                    color: Color(0xff797979)),
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
              height: SizeConfig.blockSizeVertical! * 7.8,
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
    // ignore: dead_code
    SizeConfig().init(context);
    return SafeArea(
        child: indicator
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  toolbarHeight: 70,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  leading: Container(
                    width: SizeConfig.blockSizeHorizontal! * 3.0,
                    height: SizeConfig.blockSizeVertical! * 3.0,
                    margin: EdgeInsets.only(left: 15),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        "Assets/Image/Arrow_left.png",
                        width: SizeConfig.blockSizeHorizontal! * 3.3,
                        height: SizeConfig.blockSizeVertical! * 3.3,
                      ),
                    ),
                  ),
                  title: Container(
                      height: 30,
                      margin: EdgeInsets.only(top: 10, left: 2, right: 8),
                      child: Text(
                        description,
                        style: TextStyle(
                            fontFamily: "inter,Medium",
                            fontSize: SizeConfig.safeBlockVertical! * 2.7,
                            color: Color(0xFF000000)),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                      )),
                ),
                bottomNavigationBar: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        //color: Colors.blue,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: momsent == false ? Colors.blue : Colors.green
                            //momsent != true ? Colors.blue : Colors.blue,
                            ),
                        child: userId == result?.response.owner_id.id
                            ? TextButton(
                                onPressed: () {
                                  if (confrence != null &&
                                      status == "Completed") {
                                    if (momsent != true) {
                                      _showDialog();
                                    } else {}
                                  } else {
                                    if (momsent == true) {
                                      // CommonUtils.toastMessage("Mom is Allready Send");
                                    } else {
                                      CommonUtils.toastMessage(
                                          "Confrence is Not Available");
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                child: Text(
                                  'Send Meeting Minutes',
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
                            : SizedBox()),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.pink,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(PageRoutes.homePage);
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: Text(
                          'Exit',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                body: result?.response.id.isNotEmpty ?? false
                    ? ListView(
                        children: [
                          Container(
                              margin:
                                  EdgeInsets.only(left: 15, right: 15, top: 15),
                              //height: publicNote.isNotEmpty ? 200 : 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffE8E8E8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // agendas != null?

                                  Container(
                                      //height: 40,
                                      margin: EdgeInsets.only(
                                          left: 12,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      child: Text("Common public Notes",
                                          style: TextStyle(
                                              fontFamily: "inter,SemiBold",
                                              fontSize: SizeConfig
                                                      .safeBlockVertical! *
                                                  2.5,
                                              color: Color(0xFF4385F5)))),
                                  publicNote.isNotEmpty
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: 12, right: 15, top: 5),
                                          child: Html(data: publicNote),
                                        )
                                      : SizedBox()
                                ],
                              )),
                          for (var i = 0; i < agendas!.length; i++)
                            Container(
                                // height:
                                //     MediaQuery.of(context).size.height * 0.055,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffE8E8E8),
                                ),
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 10),
                                child: ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 5, left: 5),
                                    child: Text(agendas?[i].name ?? "",
                                        style: TextStyle(
                                            fontFamily: "inter,SemiBold",
                                            fontSize:
                                                SizeConfig.safeBlockVertical! *
                                                    2.5,
                                            color: Color(0xFF4385F5))),
                                  ),
                                  subtitle: agendas?[i].description != ""
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              top: 8, bottom: 8),
                                          child: Html(
                                            data: agendas?[i].description,
                                            shrinkWrap: true,
                                          ),
                                        )
                                      : SizedBox(),
                                  dense: true,
                                )),
                          Container(
                              margin:
                                  EdgeInsets.only(left: 15, right: 15, top: 8),
                              //height: privateNote.isNotEmpty ? 200 : 50,
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
                                          left: 12,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      child: Text("Private Notes",
                                          style: TextStyle(
                                              fontFamily: "inter,SemiBold",
                                              fontSize: SizeConfig
                                                      .safeBlockVertical! *
                                                  2.5,
                                              color: Color(0xFF4385F5)))),
                                  privateNote.isNotEmpty
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: 12, right: 15),
                                          child: Html(
                                            data: privateNote,
                                            shrinkWrap: true,
                                          ))
                                      : SizedBox()
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 25.0, left: 10.0),
                                          child: Text(
                                            "Meeting Details",
                                            style: TextStyle(
                                                fontFamily: "inter,SemiBold",
                                                fontSize: SizeConfig
                                                        .safeBlockVertical! *
                                                    2.5,
                                                color: Color(0xFF4385F5)),
                                          ),
                                        ),
                                      ],
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
                                                        maxWidth: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.40),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            top: 12),
                                                    child: Text(
                                                      description,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "inter,SemiBold",
                                                          fontSize: SizeConfig
                                                                  .blockSizeVertical! *
                                                              2.1,
                                                          color: Color(
                                                              0xFF252629)),
                                                    ),
                                                  )
                                                : Container(
                                                    constraints: BoxConstraints(
                                                        minWidth: 20,
                                                        maxWidth: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.41),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 15.0,
                                                            top: 12),
                                                    child: Text(
                                                      description,
                                                      style: TextStyle(
                                                          fontFamily: "inter,regular",
                                                          fontSize: SizeConfig
                                                              .blockSizeVertical! *
                                                              1.8,
                                                          color: Color(0xff797979)
                                                      ),
                                                    ),
                                                  ),
                                            result?.response.conference != null
                                                ? Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 5, top: 12),
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
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 5.0, top: 12),
                                                    child: Text(
                                                      result
                                                              ?.response
                                                              .conference!
                                                              .type ??
                                                          "",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "inter,SemiBold",
                                                          fontSize: SizeConfig
                                                                  .blockSizeVertical! *
                                                              1.8,
                                                          color: Color(
                                                              0xFF4385F5)),
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 12.0),
                                          child: Text(
                                            totalTime,
                                            style: TextStyle(
                                                fontFamily: "inter,SemiBold",
                                                fontSize: SizeConfig
                                                        .safeBlockVertical! *
                                                    1.8,
                                                color: Color(0xFF252629)),
                                          ),
                                        )
                                      ],
                                    ),
                                    result?.response.conference != null
                                        ? Wrap(children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10.0, top: 12),
                                              child: Text(
                                                description,
                                                style: TextStyle(
                                                    fontFamily: "inter,regular",
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical! *
                                                        1.8,
                                                    color: Color(0xff797979)),
                                              ),
                                            )
                                          ])
                                        : SizedBox(
                                            height: 5,
                                          ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 15.0, left: 10.0),
                                      child: Text(
                                        membersCount,
                                        style: TextStyle(
                                            fontFamily: "inter,SemiBold",
                                            fontSize:
                                                SizeConfig.safeBlockVertical! *
                                                    2.5,
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
                                                        2.1,
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
                                                          //participantsArray.length != null ?
                                                          Center(
                                                        child:
                                                            FlutterImageStack(
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
                                                        2.1,
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
                                                        child:
                                                            FlutterImageStack(
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
                                        ),
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
                                                    2.5,
                                            color: Color(0xFF4385F5)),
                                      ),
                                    ),
                                    doucementList(fileurl),
                                    // SizedBox(height: 5,),
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
                                  EdgeInsets.only(left: 15, right: 15, top: 15),
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
                                          left: 10,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      child: Text("Agenda",
                                          style: TextStyle(
                                              fontFamily: "inter,SemiBold",
                                              fontSize: SizeConfig
                                                      .safeBlockVertical! *
                                                  2.5,
                                              color: Color(0xFF4385F5)))),
                                  for (var i = 0;
                                      i < agendaNameArray.length;
                                      i++)
                                    ListTile(
                                      title: Container(
                                          margin: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(agendaNameArray[i],
                                              style: TextStyles
                                                  .blueSimpleContent)),
                                      subtitle: Container(
                                          margin: EdgeInsets.only(
                                              right: 15, left: 10),
                                          child: Html(data: agendadesArray[i])),
                                    )
                                ],
                              )),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      )
                    : Center(child: Text("Data not found"))));
  }
}
