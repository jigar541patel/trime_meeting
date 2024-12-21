import 'dart:async';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/Utils/SizeConfig.dart';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:flutter/material.dart';
import '../Helper/ApiManager/ApiManager.dart';
import '../Helper/Utils/common_utils.dart';
import '../Helper/style/styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
        child: SplashPage(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xffffffff),
              Color(0xffffffff),
            ],
          ),
        )));
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var login = false;
  var islogin = false;

  @override
  void initState() {
    super.initState();
    check();
    Timer(const Duration(seconds: 3), () {
      if (islogin) {
        getFcmToken();
        // Navigator.popAndPushNamed(
        //   context,
        //   PageRoutes.homePage,
        // );
      } else {
        Navigator.popAndPushNamed(
          context,
          PageRoutes.introScreen,
        );
      }
    });
  }

  check() async {
    islogin = await sharePrefrence.getBool("isLogin");
    if (islogin == null) {
      islogin = false;
    }
  }
   getFcmToken() async {
     var userId = await sharePrefrence.getString("userId");
    var fCMToken = await sharePrefrence.getString("FCM Token");
    Map parameters = {"fcmRegisterToken": "$fCMToken", "userId": "$userId"};
    var result = await ApiManager.getNotification(parameters);
    print(result);
    print("fcms");
    if (result?["status"] == "Success") {
       Navigator.popAndPushNamed(
          context,
          PageRoutes.homePage,
        );
    } else {
      CommonUtils.toastMessage(result["message"]);
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(child:  WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Stack(children: [
      Center(
        child: Image.asset(
          "Assets/Image/logo_tm.png",
          fit: BoxFit.fill,
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomCenter,
          child: Text("Version 1.0", style: TextStyles.decriptionTextStyles))
      ])
    ));
  }
}
