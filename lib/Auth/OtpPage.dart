import 'dart:async';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:Trime/Auth/Otpverify.dart';
import 'package:Trime/Helper/ApiManager/ApiManager.dart';
import 'package:Trime/Helper/ApiManager/Modals/UpdatePassword.dart';
import 'package:Trime/Helper/ApiManager/Url.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/Utils/common_utils.dart';
import 'package:Trime/Helper/Utils/regx.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  String id = "";
  String userEmail = "";

  OtpPage({Key? key, required this.id, required this.userEmail})
      : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String currentText = "";
  TextEditingController OTp = TextEditingController();
  TextEditingController getOTPwithEmail = TextEditingController();
  late UpdatePassword result;
  late Timer _timer;
  int _start = 30;
  int allowResendOtp = 2;

  @override
  void initState() {
    super.initState();
    print(widget.id);
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
// showpause = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  ResendOTpwithEmail() async {
    var url = Url.forgetPasswordApi;
    Map parameters = {
      "email": widget.userEmail,
    };
    if (widget.userEmail.isEmpty) {
      CommonUtils.toastMessage("Invalid Email!");
    } else if (!regx.regExp.hasMatch(widget.userEmail)) {
      CommonUtils.toastMessage("Invalid Email!");
    } else {
      var result = await ApiManager.ForgetPasswordApi(parameters);
      CommonUtils.toastMessage(result["message"]);
      var id = result["response"]["_id"];
      Get.to(OtpVerifyPage(
        id: id,
        userEmail: widget.userEmail,
      ));
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 251,
                  width: MediaQuery.of(context).size.width * 2,
                  color: HexColors.blueColor,
                ),
                Positioned(
                    top: 15,
                    // left: 20,
                    child: IconButton(
                      icon: Image.asset(
                        "Assets/Image/Arrow_left.png",
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.toNamed(PageRoutes.forgotPassPage);
                      },
                    )),
                Positioned(
                    top: 35,
                    right: 20,
                    child: Image.asset("Assets/Image/logo.png")),
                Positioned(
                    top: 55,
                    right: -120,
                    bottom: 5,
                    child: Image.asset("Assets/Image/calendar.png")),
                Positioned(
                    top: 25,
                    left: 30,
                    child: Image.asset("Assets/Image/Group 2427.png")),
                const Positioned(
                    bottom: 45,
                    left: 30,
                    child: Text(
                      "MFA Verification",
                      style: TextStyles.whiteTitleTextStyle,
                    )),

              ],
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(left: 41),
              child: const Text(
                "OTP",
                style: TextStyles.blackSimpleContent,
              ),
            ),
            PinCodeTextField(
              controller: OTp,
              scrollPadding: EdgeInsets.only(left: 20, right: 20),
              mainAxisAlignment: MainAxisAlignment.center,
              keyboardType: TextInputType.number,
              length: 6,

              obscureText: false,
              //  animationType: AnimationType.fade,
              pinTheme: PinTheme(
                selectedFillColor: Colors.white,
                activeFillColor: Colors.white,
                activeColor: HexColors.blueColor,
                inactiveFillColor: Color(0xffF3F3F3),
                inactiveColor: Colors.white,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 40,
                fieldWidth: 40,
              ),
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              onChanged: (value) {
                print(value);
                setState(() {
                  currentText = value;
                });
              },
              appContext: context,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    verify();
                    // Get.toNamed(PageRoutes.homePage);
                  },
                  icon: Image.asset("Assets/Image/forward.png"),
                  iconSize: 52,
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  // alignment: Alignment.centerLeft,
                  child: _start == 0
                      ? TextButton(
                          onPressed: () {
                            ResendOTpwithEmail();
                          },
                          child: Text("Resend OTP"))
                      : Text("Resend OTP"),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
  verify() async {

    if (OTp.text.isEmpty) {
      CommonUtils.toastMessage("OTP is Required?");
    }


    else {
      Map parameters = {"email": widget.userEmail, "otp": OTp.text};

      var result = await ApiManager.mfaVerify(parameters);

      if (result["status"]) {
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
        getFcmToken(result["response"]["user"]["_id"]);
        CommonUtils.toastMessage("sucessfully login");
        Get.toNamed(PageRoutes.homePage);
      } else {
        CommonUtils.toastMessage(result!.message!);
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
}
