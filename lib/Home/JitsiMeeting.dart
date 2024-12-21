import 'dart:io';
import 'package:Trime/Helper/ApiManager/ApiManager.dart';
import 'package:Trime/Helper/ApiManager/Url.dart';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

// import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Helper/ApiManager/Modals/MeetingDetails/conferenceModel.dart';
import '../Helper/PageRoute.dart';
import '../Helper/Utils/common_utils.dart';
import 'HomePage.dart';

class Meeting extends StatefulWidget {
  String roomId = "";
  String ownerId = "";
  String meetingId = "";
  String? meetingName = "";
  conferences? conference;

  Meeting(
      {Key? key,
      required this.roomId,
      required this.ownerId,
      required this.meetingId,
      this.meetingName,
      required this.conference})
      : super(key: key);

  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final serverText = TextEditingController();
  String slash = "/";
  final roomText = TextEditingController();
  final subjectText = TextEditingController();
  final nameText = TextEditingController();
  final emailText = TextEditingController();
  final iosAppBarRGBAColor = TextEditingController(); //transparent blue
  bool? isAudioOnly = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;
  bool? isEnablePolls = true;
  String jitsiToken = "";
  bool isOpen = true;

  @override
  void initState() {
    super.initState();

    subjectText.text = widget.meetingName != null ? widget.meetingName! : '';

    debugPrint("jitsi the conference we have is " +
        widget.conference!.jitsiMeeting.toString());
    debugPrint("jitsi the conference type we have is " +
        widget.conference!.type.toString());
    callApi();
    // JitsiMeet.addListener(JitsiMeetingListener(
    //     onConferenceWillJoin: _onConferenceWillJoin,
    //     onConferenceJoined: _onConferenceJoined,
    //     onConferenceTerminated: _onConferenceTerminated,
    //     onError: _onError));
  }

  callApi() async {
    await signinJitsiTokenApi();
  }

  @override
  void dispose() {
    super.dispose();
    // JitsiMeet.removeAllListeners();
  }

  MeetingComplete() async {
    var result = await ApiManager.GetMeetingComplete(widget.meetingId);

    if (result["status"]) {
      // JitsiMeet.closeMeeting();

      // Get.toNamed(PageRoutes.homePage);
      isOpen = false;
      Get.offAll(() => Homepage());
    } else {
      CommonUtils.toastMessage("");
    }
  }

  signinJitsiTokenApi() async {
    var url = Url.signJassToken;
    nameText.text = await sharePrefrence.getString("userName");
    String userimage = await sharePrefrence.getString("userImage");
    emailText.text = await sharePrefrence.getString("userEmail");
    String userId = await sharePrefrence.getString("userId");
    String userType = await sharePrefrence.getString("userType");
    int rool = widget.ownerId == userId ? 1 : 0;
    Map parameter = {
      "userDetail": {
        "id": userId,
        "name": nameText.text,
        "email": emailText.text,
        "avatar": "https://app.trime.ai/image/default_user.png"
      },
      "role": rool
    };
    var result = await ApiManager.signinJaasToken(parameter);
    // elements = result as List;
    if (result!["status"]) {
      jitsiToken = result["response"];
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Trime'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: kIsWeb
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.30,
                    child: meetConfig(),
                  ),
                  Container(
                      width: width * 0.60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            color: Colors.white54,
                            child: SizedBox(
                              width: width * 0.60 * 0.70,
                              height: width * 0.60 * 0.70,
                              // child: JitsiMeetConferencing(
                              //   extraJS: const [
                              //     // extraJs setup example
                              //     '<script>function echo(){console.log("echo!!!")};</script>',
                              //     '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                              //   ],
                              // ),
                            )),
                      ))
                ],
              )
            : meetConfig(),
      ),
    );
  }

  Widget meetConfig() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 16.0,
          ),

          const SizedBox(
            height: 14.0,
          ),

          TextField(
            controller: subjectText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Subject",
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: nameText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Display Name",
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: emailText,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email",
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: iosAppBarRGBAColor,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "AppBar Color(IOS only)",
                hintText: "Hint: This HAS to be in HEX RGBA format"),
          ),
          const SizedBox(
            height: 14.0,
          ),
          // CheckboxListTile(
          //   title: const Text("Audio Only"),
          //   value: isAudioOnly,
          //   onChanged: _onAudioOnlyChanged,
          // ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Audio Muted"),
            value: isAudioMuted,
            onChanged: _onAudioMutedChanged,
          ),
          const SizedBox(
            height: 14.0,
          ),
          CheckboxListTile(
            title: const Text("Video Muted"),
            value: isVideoMuted,
            onChanged: _onVideoMutedChanged,
          ),
          const Divider(
            height: 48.0,
            thickness: 2.0,
          ),
          SizedBox(
            height: 64.0,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () async {
                if (widget.conference!.type == "myvc") {
                  if (Platform.isAndroid) {
                    // Android-specific code
                    if (!await launchUrl(
                        Uri.parse(widget.conference!.jitsiMeeting!),
                        mode: LaunchMode.externalApplication)) {
                      throw Exception(
                          'Could not launch ${widget.conference!.jitsiMeeting!}');
                    }
                  } else if (Platform.isIOS) {
                    // iOS-specific code
                    if (!await launchUrl(
                        Uri.parse(widget.conference!.jitsiMeeting!))) {
                      throw Exception(
                          'Could not launch ${widget.conference!.jitsiMeeting!}');
                    }
                  }
                } else {
                  _joinMeeting();
                }
              },
              child: const Text(
                "Join Meeting",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.blue)),
            ),
          ),
          const SizedBox(
            height: 48.0,
          ),
        ],
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String? serverUrl =
        "https://8x8.vc/vpaas-magic-cookie-e83855eb7e8e4caba2055f5bf0dc38bb/";
    Map<FeatureFlag, Object> featureFlags = {};
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        // featureFlags
        featureFlags[FeatureFlag.isCallIntegrationEnabled] = false;
        featureFlags[FeatureFlag.isRecordingEnabled] = false;
        featureFlags[FeatureFlag.isMeetingPasswordEnabled] = false;
        featureFlags[FeatureFlag.isTileViewEnabled] = false;
        featureFlags[FeatureFlag.isToolboxAlwaysVisible] = false;
        featureFlags[FeatureFlag.isLiveStreamingEnabled] = false;
        // featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
//           featureFlags[FeatureFlagEnum.RECORDING_ENABLED] = false;
        //         featureFlags[FeatureFlagEnum.MEETING_PASSWORD_ENABLED] = false;
        //       featureFlags[FeatureFlagEnum.TILE_VIEW_ENABLED] = false;
        //     featureFlags[FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE] = false;
        //   featureFlags[FeatureFlagEnum.LIVE_STREAMING_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird

        featureFlags[FeatureFlag.isPipEnabled] = false;
        featureFlags[FeatureFlag.isIosRecordingEnabled] = false;
        featureFlags[FeatureFlag.isMeetingPasswordEnabled] = false;
        featureFlags[FeatureFlag.isTileViewEnabled] = false;
        featureFlags[FeatureFlag.isToolboxAlwaysVisible] = false;
        featureFlags[FeatureFlag.isLiveStreamingEnabled] = false;
        // featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
        // featureFlags[FeatureFlagEnum.RECORDING_ENABLED] = false;
        // featureFlags[FeatureFlagEnum.MEETING_PASSWORD_ENABLED] = false;
        // featureFlags[FeatureFlagEnum.TILE_VIEW_ENABLED] = false;
        // featureFlags[FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE] = false;
        // featureFlags[FeatureFlagEnum.LIVE_STREAMING_ENABLED] = false;
      }
    }
    var options = JitsiMeetingOptions(
        // room: widget.roomId
        // ,
        roomNameOrUrl: widget.roomId,
        serverUrl: serverUrl,
        token: jitsiToken,
        isAudioOnly: isAudioOnly,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
        featureFlags: featureFlags);
    // ..token = jitsiToken
    // ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
    // ..audioOnly = isAudioOnly
    // ..audioMuted = isAudioMuted
    // ..videoMuted = isVideoMuted!
    // ..featureFlags.addAll(featureFlags);

    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onConferenceWillJoin: (url) => _onConferenceWillJoin(url),
        //print("onConferenceWillJoin: url: $url"),
        onConferenceJoined: (url) => _onConferenceJoined(url),
        // print("onConferenceJoined: url: $url"),
        onConferenceTerminated: (url, error) => _onConferenceTerminated(
            url), //print("onConferenceTerminated: url: $url, error: $error"),
      ),
    );
  }

  // _joinMeeting() async {
  //   // String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;
  //   String? serverUrl =
  //       "https://8x8.vc/vpaas-magic-cookie-e83855eb7e8e4caba2055f5bf0dc38bb/";
  //   // Enable or disable any feature flag here
  //   // If feature flag are not provided, default values will be used
  //   // Full list of feature flags (and defaults) available in the README
  //   // Map<FeatureFlagEnum, bool> featureFlags = {
  //   //   FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
  //   // };
  //
  //   if (!kIsWeb) {
  //     // Here is an example, disabling features for each platform
  //     if (Platform.isAndroid) {
  //       // Disable ConnectionService usage on Android to avoid issues (see README)
  //       featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
  //       featureFlags[FeatureFlagEnum.RECORDING_ENABLED] = false;
  //       featureFlags[FeatureFlagEnum.MEETING_PASSWORD_ENABLED] = false;
  //       featureFlags[FeatureFlagEnum.TILE_VIEW_ENABLED] = false;
  //       featureFlags[FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE] = false;
  //       featureFlags[FeatureFlagEnum.LIVE_STREAMING_ENABLED] = false;
  //     } else if (Platform.isIOS) {
  //       // Disable PIP on iOS as it looks weird
  //       featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
  //       featureFlags[FeatureFlagEnum.RECORDING_ENABLED] = false;
  //       featureFlags[FeatureFlagEnum.MEETING_PASSWORD_ENABLED] = false;
  //       featureFlags[FeatureFlagEnum.TILE_VIEW_ENABLED] = false;
  //       featureFlags[FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE] = false;
  //       featureFlags[FeatureFlagEnum.LIVE_STREAMING_ENABLED] = false;
  //     }
  //   }
  //
  //   var options = JitsiMeetingOptions(room: widget.roomId)
  //     ..serverURL = serverUrl
  //     ..token = jitsiToken
  //     ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
  //     ..audioOnly = isAudioOnly
  //     ..audioMuted = isAudioMuted
  //     ..videoMuted = isVideoMuted!
  //     ..featureFlags.addAll(featureFlags);
  //
  //   debugPrint("JitsiMeetingOptions: $options");
  //
  //   await JitsiMeet.joinMeeting(
  //     options,
  //     listener: JitsiMeetingListener(
  //         onConferenceWillJoin: (message) {
  //           debugPrint("${options.room} will join with message: $message");
  //         },
  //         onConferenceJoined: (message) {
  //           debugPrint("${options.room} joined with message: $message");
  //         },
  //         onConferenceTerminated: (message) {
  //           debugPrint("${options.room} terminated with message: $message");
  //         },
  //         genericListeners: [
  //           JitsiGenericListener(
  //               eventName: 'readyToClose',
  //               callback: (dynamic message) {
  //                 debugPrint("readyToClose callback");
  //               }),
  //         ]),
  //   );
  // }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  Future<void> _onConferenceTerminated(message) async {
    if (isOpen) {
      var owherId = await sharePrefrence.getString("owherId");
      var id = await sharePrefrence.getString("userId");

      // debugPrint("_onConferenceTerminated broadcasted with message: $message");
      debugPrint(
          "jitsi is meeting closed before condition ==> " + message.toString());
      if (id == owherId) {
        debugPrint("jitsi is inside ==> id == owherId ");
        MeetingComplete();
      } else {
        // JitsiMeet.removeAllListeners();
        // JitsiMeet.closeMeeting();

        debugPrint(
            "jitsi is meeting closed we are going back PageRoutes.homePage");
        // Get.toNamed(PageRoutes.homePage);
        isOpen = false;
        Get.offAll(() => Homepage());
      }
    }
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
    debugPrint("jitsi is meeting error $error");
  }
}
