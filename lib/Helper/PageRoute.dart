import 'package:Trime/Auth/ForgotPassword.dart';
import 'package:Trime/Auth/Otpverify.dart';
import 'package:Trime/Auth/SignupPage.dart';
import 'package:Trime/Auth/loginPage.dart';
import 'package:Trime/Create%20Task/AddAttachment.dart';
import 'package:Trime/Create%20Task/Assign.dart';
import 'package:Trime/Create%20Task/Assist.dart';
import 'package:Trime/Create%20Task/CreateTask.dart';
import 'package:Trime/Create%20Task/SubTask.dart';
import 'package:Trime/Create%20Task/Tags.dart';
import 'package:Trime/Create%20Task/watcher.dart';
import 'package:Trime/Home/HomePage.dart';
import 'package:Trime/Home/Meetingdetails.dart';
import 'package:Trime/Home/ScreenDetals.dart';
import 'package:Trime/Intro/IntroPage.dart';
import 'package:Trime/Meetings/Agenda.dart';
import 'package:Trime/Meetings/Attachment.dart';
import 'package:Trime/Meetings/CreateMeeting.dart';
import 'package:Trime/Meetings/ZoomIntergation.dart';
import 'package:Trime/Meetings/conferenc.dart';
import 'package:Trime/Meetings/participant.dart';
import 'package:Trime/Meetings/tags.dart';
import 'package:Trime/Profile/ChangePassword.dart';
import 'package:Trime/Profile/EditProfile.dart';
import 'package:Trime/Profile/ProfilePage.dart';
import 'package:Trime/webpages/service_webpage.dart';
import 'package:flutter/material.dart';

import '../Home/MeetingDetailsNotes.dart';
import '../Home/fullScreenVideo.dart';
import '../Intro/Intropages.dart';

class PageRoutes {
  static const String introScreen = 'Intropages';
  static const String fullScreen = 'FullScreenVideo';
  static const String loginPage = 'LoginPage';
  static const String signupPage = 'SignupPage';
  static const String forgotPassPage = 'ForgotPassPage';
  static const String homePage = 'HomePage';
  static const String profilePage = 'ProfilePage';
  static const String changePass = 'ChangePassword';
  static const String editPage = 'EditPage';
  static const String meetingpage = 'MeetingDetailsPage';
  static const String screendetails = 'ScreenDetailsPage';
  static const String webView = 'WebView';
  static const String otpVerifyPage = 'OtpVerifyPage';
  static const String createmeeting = 'CreateMeeting';
  static const String AddTags = "Addtags";
  static const String participant = "Participant & Watchers";
  static const String conference = "Conferencing";
  static const String agenda = "Agenda";
  static const String attachment = "Attachment";
  static const String Task = 'CreateTasks';
  static const String SubTask = 'AddSubTask';
  static const String TagTask = 'TagsTask';
  static const String AssignTask = 'Assign To';
  static const String AssistTask = 'Asist TO';
  static const String WatcherTask = 'Watchers';
  static const String AddAttachmentTask = 'AddAttachment';
  static const String ZoomIntergration = 'ZoomIntergration';
  static const String meetingDetailsNotes = 'MeetingDetailsNotes';
  //MeetingDetailsNotes
  Map<String, WidgetBuilder> routes() {
    return {
      introScreen: (context) => Intropages(),
      loginPage: (context) => LoginPage(),
      signupPage: (context) => SignupPage(),
      forgotPassPage: (context) => ForgotpasswordPage(),
      homePage: (context) => Homepage(),
      profilePage: (context) => ProfilePage(
            id: "",
          ),
      changePass: (context) => ChangePassword(),
      editPage: (context) => EditProfile(),
      meetingpage: (context) => MeetingDetailsPage(id: "",),
      screendetails: (context) => ScreenDetailsPage(),
      otpVerifyPage: (context) => OtpVerifyPage(
            id: "",
            userEmail: "",
          ),
      webView: (context) => WebViewPage(
            url: "",isLogin: '',
          ),
      createmeeting: (context) => CreateMeetingPage(),
      AddTags: (context) => TagsPage(),
      participant: (context) => ParticipantandWatcherpage(),
      conference: (context) => ConferencingPage(),
      agenda: (context) => AgendaPage(),
      attachment: (context) => AttachmentPage(),
      Task: (context) => CreateTaskPage(taskArray: '',),
      SubTask: (context) => SubTaskPage(),
      TagTask: (context) => TagsTaskPage(),
      AssignTask: (context) => AssignPage(),
      AssistTask: (context) => AssistPage(),
      WatcherTask: (context) => WatchersPage(),
      AddAttachmentTask: (context) => AddAttachmentPage(),
      ZoomIntergration:(context) => ZoomIntergationPage(),
      meetingDetailsNotes:((context) => MeetingDetailsNotes(id: '',)),
      fullScreen:((context) => FullScreenVideo(Link: '',))
    };
  }
}
