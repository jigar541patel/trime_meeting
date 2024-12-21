import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:Trime/Home/Meetingdetails.dart';
import 'package:Trime/splash/splash_servicePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Home/TaskScreen.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    //'This channel is used for important notifications.', // description
    importance: Importance.high,

    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// ignore: unused_element


Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  await Firebase.initializeApp();
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` be
  // fore using other Firebase services.
  print('message--${message.data}');

  String type = message.data["body"].split(",")[3];
  var data = message.data["body"]!.split(",")[2];
  var id = data.split("/");
  if(type.contains("task")){
    Get.to(Task(

    ));
  }
  else{
    Get.to(MeetingDetailsPage(
      id: id[5] ?? "",
    ));
  }
  print('Handling a background message ${message.data}');
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String fcmToken;
  var islogin = false;

  // getToken() async {
  //   islogin = await sharePrefrence.getBool("isLogin");
  //   if (islogin == null && islogin == false) {
  //     islogin = false;
  //   }else{
  //     if(islogin){
  //   fcmToken = (await FirebaseMessaging.instance.getToken())!;
  //   dynamic fcmtoken = await sharePrefrence.saveString("FCM Token", fcmToken);
  //   print(fcmToken);
  //   print("FCM token");
  //    initMessaging();
  //    print("test");
  //     }
  //   }
  // }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin fltNotification;

  var meetingId;
 

  var androidDetails = AndroidNotificationDetails(
    "1",
    "channelName",
  );
  var iosDetails = IOSNotificationDetails();

  @override
  void initState() {
    super.initState();

    getToken();
    initMessaging();
  }

  getToken() async {
    fcmToken = (await FirebaseMessaging.instance.getToken())!;
    dynamic fcmtoken = await sharePrefrence.saveString("FCM Token", fcmToken);
    print(fcmToken);
    print("FCM token");
  }


  void initMessaging() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      // print('message--${message!.data}');
      print("onMessageOpenedApp: $message");
      if(message!=null) {
        String type = message.data["body"].split(",")[3];
        var data = message.data["body"]!.split(",")[2];
        var id = data.split("/");
        if(type.contains("task")){
          Get.to(Task(

          ));
        }
        else{
          Get.to(MeetingDetailsPage(
            id: id[5] ?? "",
          ));
        }
      }

    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('message--${message.data}');
      print("onMessageOpenedApp: $message");
      String type = message.data["body"].split(",")[3];
      var data = message.data["body"]!.split(",")[2];
      var id = data.split("/");
      if(type.contains("task")){
        Get.to(Task(

        ));
      }
      else{
        Get.to(MeetingDetailsPage(
          id: id[5] ?? "",
        ));
      }
    });

    var androiInit = AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInit = IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
    fltNotification = FlutterLocalNotificationsPlugin();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('message--${message.data}');
      print("onMessageOpenedApp: $message");
      String type = message.data["body"].split(",")[3];
      var data = message.data["body"]!.split(",")[2];
      var id = data.split("/");
      if(type.contains("task")){
        Get.to(Task(

        ));
      }
      else{
        Get.to(MeetingDetailsPage(
          id: id[5] ?? "",
        ));
      }
    });
    FirebaseMessaging.onBackgroundMessage((message)async {
      String type = message.data["body"].split(",")[3];
      var data = message.data["body"]!.split(",")[2];
      var id = data.split("/");
      if(type.contains("task")){
        Get.to(Task(

        ));
      }
      else{
        Get.to(MeetingDetailsPage(
          id: id[5] ?? "",
        ));
      }
    });

    fltNotification.initialize(initSetting,
        onSelectNotification: (payload) async {
         
          String type = payload!.split(",")[3];
          var data = payload!.split(",")[2];
         var id = data.split("/");
          if(type.contains("task")){
            Get.to(Task(

            ));
          }
          else{
            Get.to(MeetingDetailsPage(
              id: id[5] ?? "",
            ));
          }




    });

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print('notification--$notification');

      print(message.data["body"]);
      var data = message.data["body"].split(",")[2];

      meetingId = data.split("/");

      print("raj");

      if (notification != null && android != null) {
        fltNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails,
            payload: message.data["body"]);
      }
    });

  }

  // void initState() {
  //   super.initState();
  //   check();
  //   // getNotificationType();
  //   var initializationSettingsAndroid =
  //       new AndroidInitializationSettings('ic_launcher');
  //   var initialzationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var initializationSettings =
  //       InitializationSettings(android: initialzationSettingsAndroid);
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings);

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     // if (islogin) {
  //     print(message.data["body"]);
  //    // print("test");
  //     print(islogin);
  //     var data = message.data["body"].split(",");
  //     var value = data[0];
  //     var meetingNameData = value.split(":");
  //     var type = meetingNameData[0];
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification!.android;
  //     print(type);
  //     print("raj");

  //     if (type == 'Meeting Name ') {
  //       if (notification != null && android != null) {
  //         flutterLocalNotificationsPlugin.show(
  //             notification.hashCode,
  //             notification.title,
  //             notification.body,
  //             NotificationDetails(
  //               android: AndroidNotificationDetails(
  //                 channel.id,
  //                 channel.name,

  //                 //channel.description,
  //                 color: Colors.blue,
  //                 icon: "@mipmap/ic_launcher",
  //               ),
  //             ));
  //         // }
  //       }
  //     }
  //     else{
  //       print("abcd");

  //        var meetingNameData = type.split("-");
  //     var type1 = meetingNameData[0];
  //     if(type1 == "Name of task "){
  //       print(type1);
  //       print("test");
  //     }
  //     }
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       showDialog(
  //           context: context,
  //           builder: (_) {
  //             return AlertDialog(
  //               title: Text(notification.title ?? ""),
  //               content: SingleChildScrollView(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [Text(notification.body ?? "")],
  //                 ),
  //               ),
  //             );
  //           });
  //     }
  //   });

  //   getToken();
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, xyz) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter_ScreenUtil',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(button: TextStyle(fontSize: 45.sp)),
        ),
        builder: (context, widget) {
          // ScreenUtil.init(context);
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: GetMaterialApp(
              title: 'Trime',
              debugShowCheckedModeBanner: false,
              enableLog: true,
              // locale: TranslationService.locale,
              // fallbackLocale: TranslationService.fallbackLocale,
              // translations: TranslationService(),
              routes: PageRoutes().routes(),
              home: SplashScreen(),
              theme: ThemeData(primarySwatch: Colors.blue),
            ),
          );
        },
      ),
    );
  }
}
