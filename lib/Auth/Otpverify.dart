import 'dart:async';

import 'package:Trime/Helper/ApiManager/ApiManager.dart';
import 'package:Trime/Helper/ApiManager/Modals/UpdatePassword.dart';
import 'package:Trime/Helper/ApiManager/Url.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/Utils/common_utils.dart';
import 'package:Trime/Helper/Utils/regx.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:Trime/webpages/service_webpage.dart';
import 'package:Trime/webpages/terms&conditions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerifyPage extends StatefulWidget {
  String id = "";
  String userEmail = "";
  OtpVerifyPage({Key? key, required this.id, required this.userEmail})
      : super(key: key);

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  String currentText = "";
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
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

  updatePasswordWithOTP() async {
    print("object");
    var url = Url.updatePasswordApi;
    Map parameters = {
      "user_id": widget.id,
      "otp": OTp.text,
      "new_password": newpassword.text,
      "confirm_password": confirmpassword.text
    };
    if (newpassword.text.isEmpty) {
      CommonUtils.toastMessage("New password Required?");
    } else if (regx.validatePassword(newpassword.text) != null) {
      CommonUtils.toastMessage("New Password must be Atleast 1 Uppercase,1 Lowercase,1 Spical Case And Longer Than 8 Character");
    } else if (confirmpassword.text.isEmpty) {
      CommonUtils.toastMessage("Confirm Password is Required?");
    }else if (regx.validatePassword(confirmpassword.text) != null) {
      CommonUtils.toastMessage("Confrom Password must be Atleast 1 Uppercase,1 Lowercase,1 Spical Case And Longer Than 8 Character");
    } 
    
    else {
      if (newpassword.text == confirmpassword.text) {
        var result = await ApiManager.UpdatePasswordApiwithOTP(parameters);
        if (result["status"] == true) {
          Get.toNamed(PageRoutes.loginPage);
          CommonUtils.toastMessage("Password updated successfully");
        } else {
          CommonUtils.toastMessage(result["message"]);
        }
      } else {
        CommonUtils.toastMessage("Confirm Password is not match");
      }
    }
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
                      icon: Image.asset("Assets/Image/Arrow_left.png",color: Colors.white,),
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
                      "Forgot",
                      style: TextStyles.whiteTitleTextStyle,
                    )),
                const Positioned(
                    bottom: 15,
                    left: 30,
                    child: Text(
                      "Password",
                      style: TextStyles.whiteSubTitleTextStyle,
                    ))
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
              length: 4,
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
            Container(
              margin: const EdgeInsets.only(left: 41),
              child: const Text(
                "New Password",
                style: TextStyles.blackSimpleContent,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColors.lightWhiteOpacityColor,
              ),
              child: TextFormField(
                controller: newpassword,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 20, top: 16),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: passwordVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    hintText: "Enter your Password"),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(left: 41),
              child: const Text(
                "Confirm Password",
                style: TextStyles.blackSimpleContent,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColors.lightWhiteOpacityColor,
              ),
              child: TextFormField(
                controller: confirmpassword,
                obscureText: confirmPasswordVisible,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 20, top: 16),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            confirmPasswordVisible = !confirmPasswordVisible;
                          });
                        },
                        icon: confirmPasswordVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    hintText: "Re Enter Password"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  // alignment: Alignment.centerLeft,
                  child: _start == 0
                      ? TextButton(
                          onPressed: () {
                            if (allowResendOtp > 0) {
                              allowResendOtp--;
                              ResendOTpwithEmail();
                            }
                          },
                          child: Text("Resend OTP"))
                      : Text("Resend OTP"),
                ),
                Container(
                    margin: EdgeInsets.only(right: 10),
                    // alignment: Alignment.centerLeft,
                    child: _start == 0 ? SizedBox() : Text(" in ${_start}")),
              ],
            ),
            const SizedBox(height: 30),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     TextButton(
            //         onPressed: () {},
            //         child:
            //             const Text("Resend OTP", style: TextStyles.size20Bold)),
            //     const SizedBox(width: 20),
            //     IconButton(
            //       onPressed: () {
            //         // ResendOTpwithEmail();
            //       },
            //       icon: Image.asset("Assets/Image/forward.png"),
            //       iconSize: 72,
            //     )
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                     updatePasswordWithOTP();

                    },
                    child: const Text("Update Password",
                        style: TextStyles.size20Bold)),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    updatePasswordWithOTP();
                  },
                  icon: Image.asset("Assets/Image/forward.png"),
                  iconSize: 72,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  "By signing in I agree to the",
                  style: TextStyles.size12Light,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                        minimumSize: Size.zero, padding: EdgeInsets.zero),
                    onPressed: () {
                      Get.to(termsandconditions(
                          url:
                              Url.termsconditionUrl, isLogin: "",));
                    },
                    child: const Text(" terms and conditions ",
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
                          url:
                              Url.privacypolicyUrl, isLogin: '',));
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
    );
  }
}
