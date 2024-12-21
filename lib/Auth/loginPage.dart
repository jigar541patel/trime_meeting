import 'package:Trime/Auth/OtpPage.dart';
import 'package:Trime/Helper/ApiManager/ApiManager.dart';
import 'package:Trime/Helper/ApiManager/Modals/Login.dart';
import 'package:Trime/Helper/ApiManager/Modals/VerifyEmail.dart';
import 'package:Trime/Helper/ApiManager/Url.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/Utils/common_utils.dart';
import 'package:Trime/Helper/Utils/regx.dart';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:Trime/webpages/service_webpage.dart';
import 'package:Trime/webpages/terms&conditions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/Utils/SizeConfig.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscure = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController VerifyEmail = TextEditingController();
  late loginModel result;
  late VerifyEmailId result1;
  final _formKey = GlobalKey<FormState>();

  customDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // SizedBox(
                        //   height: 5.0,
                        // ),
                        Container(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Image.asset(
                              "Assets/Image/cros.png",
                              fit: BoxFit.fill,
                            ),
                            // iconSize: 50,
                          ),
                        ),
                        //  SizedBox(
                        //     height: 10.0,
                        //   ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Text("Request Verification Mail.",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black)),
                        ) //
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
                        Container(
                            padding: EdgeInsets.only(top: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(32.0),
                                  bottomRight: Radius.circular(32.0)),
                            ),
                            child: IconButton(
                              onPressed: () {
                                verifyEmail();
                              },
                              icon: Image.asset(
                                "Assets/Image/forward.png",
                                fit: BoxFit.fill,
                              ),
                              iconSize: 72,
                            )),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }

  verifyEmail() async {
    print("object");
    var url = Url.verifyApi;
    Map parameters = {
      "email": VerifyEmail.text,
    };
    if (VerifyEmail.text.isEmpty) {
      CommonUtils.toastMessage("Enter email");
    } else if (!regx.regExp.hasMatch(VerifyEmail.text)) {
      CommonUtils.toastMessage("Invalid email");
    } else {
      var result1 = await ApiManager.VerifyApi(parameters);
      if (result1!.status!) {
        CommonUtils.toastMessage("Verification Email sent successfully");
        Get.back();
        // navigatorKey!.currentState!.dispose();
      } else {
        CommonUtils.toastMessage(result1.message!);
      }
    }
  }

  login() async {
    var url = Url.loginApi;
    // if (_formKey.currentState!.validate()) {
    // if (email.text.isEmpty || password.text.isEmpty) {
    if (email.text.isEmpty) {
      CommonUtils.toastMessage("Email is Required?");
    } else if (!regx.regExp.hasMatch(email.text)) {
      CommonUtils.toastMessage("Invalid Email!");
    } else if (password.text.isEmpty) {
      CommonUtils.toastMessage("password is Required?");
    }
    // else if (regx.validatePassword(password.text) != null) {
    //   CommonUtils.toastMessage("Password must be Atleast 1 Uppercase,1 Lowercase,1 Spical Case And Longer Than 8 Character");
    // }

    else {
      Map parameters = {
        "email_phone": email.text,
        "password": password.text,
        "isMob": true
      };

      var result = await ApiManager.loginApi(parameters);

      if (result["status"]) {
        if (result['response']['enableMfa']) {
          CommonUtils.toastMessage(result["message"]);
          Get.to(OtpPage(
            id: result['response']['_id'],
            userEmail: result['response']['email'],
          ));
        } else {
          dynamic token = await sharePrefrence.saveString(
              "token", result["response"]["token"]);
          dynamic isLogin = await sharePrefrence.saveBool("isLogin", true);
          dynamic id = await sharePrefrence.saveString(
              "userId", result["response"]["user"]["_id"]);
          dynamic phone = await sharePrefrence.saveString(
              "userPhone", result["response"]["user"]["phone"].toString());
          dynamic email = await sharePrefrence.saveString(
              "userEmail", result["response"]["user"]["email"]);
          dynamic name = await sharePrefrence.saveString(
              "userName", result["response"]["user"]["name"]);
          dynamic image = await sharePrefrence.saveString(
              "userImage", result["response"]["user"]["image"]);
          dynamic type = await sharePrefrence.saveString(
              "userType", result["response"]["user"]["userType"]);

          CommonUtils.toastMessage("sucessfully login");

          // ignore: unused_local_variable

          getFcmToken(result["response"]["user"]["_id"]);
          Get.toNamed(PageRoutes.homePage);
        }
      } else {
        CommonUtils.toastMessage(result["message"]);
      }
    }
    // }
    // }
  }

  getFcmToken(dynamic userId) async {
    var fCMToken = await sharePrefrence.getString("FCM Token");
    print(fCMToken);
    print("push fcm token");
    Map parameters = {"fcmRegisterToken": "$fCMToken", "userId": "$userId"};

    var result = await ApiManager.getNotification(parameters);
    print(result);
    print("fcms");
    if (result?["status"] == "Success") {
    } else {
      CommonUtils.toastMessage(result["message"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 2,
                    // color: HexColors.blueColor,
                  ),
                  Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        // top: 35,
                        // right: 20,

                        child: Image.asset(
                          "Assets/Image/logo_tm.png",
                          height: 80,
                          width: 110,
                        )),
                  ),
                  // Positioned(
                  //     top: 55,
                  //     right: -120,
                  //     bottom: 5,
                  //     child: Image.asset("Assets/Image/calendar.png")),
                  // Positioned(
                  //     top: 25,
                  //     left: 30,
                  //     child: Image.asset("Assets/Image/Group 2427.png")),
                  Positioned(
                      bottom: 45,
                      left: 14,
                      child: Text(
                        "Make Awesome Meetings",
                        style: TextStyle(
                            fontFamily: "inter,medium",
                            fontSize: SizeConfig.safeBlockVertical! * 3.6,
                            color: HexColors.blueColor),
                        // fontSize: SizeConfig.safeBlockVertical! * 1.8,
                        // style: TextStyles.whiteTitleTextStyle,
                      )),
                  Positioned(
                      bottom: 15,
                      left: 14,
                      child: Text(
                        "Sign In to continue",
                        style: TextStyle(
                            fontFamily: "inter,medium",
                            fontSize: SizeConfig.safeBlockVertical! * 3.2,
                            color: HexColors.blueColor),

                        // style: TextStyles.whiteSubTitleTextStyle,
                      ))
                ],
              ),
              new Divider(
                color: Colors.black,
              ),
              const SizedBox(height: 30),
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 41),
                        child: Text(
                          "Email Id",
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical! * 2.3,
                              fontFamily: "inter,SemiBold",
                              color: Color(0xFF252629)
                              // color: Color(0xffFFFFFF)
                              ),
                          // style: TextStyles.blackSimpleContent,
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 30, right: 30, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColors.lightWhiteOpacityColor,
                        ),
                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: SizeConfig.safeBlockVertical! * 2.3,
                              ),
                              hintText: "Enter your email id"),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        margin: const EdgeInsets.only(left: 41),
                        child: Text(
                          "Password",
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical! * 2.3,
                              fontFamily: "inter,SemiBold",
                              color: Color(0xFF252629)
                              // color: Color(0xffFFFFFF)
                              ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 30, right: 30, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColors.lightWhiteOpacityColor,
                        ),
                        child: TextFormField(
                          controller: password,
                          obscureText: obscure,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(left: 20, top: 16),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscure = !obscure;
                                    });
                                  },
                                  icon: obscure
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              hintStyle: TextStyle(
                                fontSize: SizeConfig.safeBlockVertical! * 2.3,
                              ),
                              hintText: "Enter your Password"),
                        ),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: TextButton(
                          onPressed: () {
                            customDialogBox(context);
                          },
                          child: Text(
                            "Verify user?",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical! * 2.3,
                              fontFamily: "intel,Light",
                              color: HexColors.blueColor,
                            ),
                            // style: TextStyle(
                            //     color: HexColors.blueColor,
                            //     fontFamily: "intel,Light",
                            //     fontSize: 15))),
                          ))),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Get.toNamed(PageRoutes.forgotPassPage);
                        },
                        child: Text("Forgot Password?",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical! * 2.3,
                              fontFamily: "intel,Light",
                              color: HexColors.blueColor,
                            ))),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     IconButton(
              //       onPressed: () {},
              //       icon: Image.asset("Assets/Image/google.png"),
              //       iconSize: 46,
              //     ),
              //     const SizedBox(width: 20),
              //     IconButton(
              //       onPressed: () {},
              //       icon: Image.asset("Assets/Image/microsoft.png"),
              //       iconSize: 46,
              //     )
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        login();
                      },
                      child: Text("Sign in",
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical! * 3.0,
                              fontFamily: "inter,Bold",
                              color: Color(0xFF000000))
                          // style: TextStyles.size20Bold)
                          )),
                  // const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      login();
                      // Get.toNamed(PageRoutes.homePage);
                    },
                    icon: Image.asset("Assets/Image/forward.png"),
                    iconSize: 52,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("A New User?",
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockVertical! * 2.8,
                          fontFamily: "intel,Light",
                          color: Color(0xffBEBEBE))),
                  // TextStyles.size15Light),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(PageRoutes.signupPage);
                      },
                      child: Text("Signup Here",
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockVertical! * 2.3,
                            fontFamily: "intel,Light",
                            color: HexColors.blueColor,
                          )
                          // TextStyle(
                          //     color: HexColors.blueColor,
                          //     fontFamily: "intel,Light",
                          //     fontSize: 15)
                          ))
                ],
              ),

              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                // runAlignment: WrapAlignment.start,
                children: [
                  const Text(
                    "By signing in I agree to the ",
                    style: TextStyles.size12Light,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: Size.zero, padding: EdgeInsets.zero),
                      onPressed: () {
                        Get.to(termsandconditions(
                          url: Url.termsconditionUrl,
                          isLogin: 'true',
                        ));
                      },
                      child: const Text("terms and conditions",
                          style: TextStyle(
                              color: HexColors.blueColor,
                              fontFamily: "intel,Light",
                              fontSize: 12))),
                  const Text(" and ", style: TextStyles.size12Light),
                  TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: Size.zero, padding: EdgeInsets.zero),
                      onPressed: () {
                        // Get.toNamed(PageRoutes.webView);
                        Get.to(WebViewPage(
                          url: Url.privacypolicyUrl,
                          isLogin: 'true',
                        ));
                      },
                      child: const Text("privacy policy.",
                          style: TextStyle(
                              color: HexColors.blueColor,
                              fontFamily: "intel,Light",
                              fontSize: 12))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
