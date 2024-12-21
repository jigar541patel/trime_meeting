import 'package:Trime/Auth/Otpverify.dart';
import 'package:Trime/Helper/ApiManager/ApiManager.dart';
import 'package:Trime/Helper/ApiManager/Modals/ForgetPassword.dart';
import 'package:Trime/Helper/ApiManager/Url.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/Utils/common_utils.dart';
import 'package:Trime/Helper/Utils/regx.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotpasswordPage extends StatefulWidget {
  const ForgotpasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotpasswordPage> createState() => _ForgotpasswordPageState();
}

class _ForgotpasswordPageState extends State<ForgotpasswordPage> {
  TextEditingController getOTPwithEmail = TextEditingController();
  late ForgetPasswordwithEmail result;

  GetOTPwithEmail() async {
  
    var url = Url.forgetPasswordApi;
    Map parameters = {
      "email": getOTPwithEmail.text,
    };
    if (getOTPwithEmail.text.isEmpty) {
      CommonUtils.toastMessage("Email is Required?");
    } else if (!regx.regExp.hasMatch(getOTPwithEmail.text)) {
      CommonUtils.toastMessage("Invalid Email!");
    } else {
      var result = await ApiManager.ForgetPasswordApi(parameters);
      CommonUtils.toastMessage(result["message"]);
      var id = result["response"]["_id"];
      Get.to(OtpVerifyPage(
        id: id,
        userEmail: getOTPwithEmail.text,
      ));
    }
  }

  @override
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
                        Get.toNamed(PageRoutes.loginPage);
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
                      "Password ?",
                      style: TextStyles.whiteSubTitleTextStyle,
                    ))
              ],
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(left: 41),
              child: const Text(
                "Email Id",
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
                controller: getOTPwithEmail,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    border: InputBorder.none,
                    hintText: "Enter your registered mail id"),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      GetOTPwithEmail();
                    },
                    child: const Text("Get OTP", style: TextStyles.size20Bold)),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    GetOTPwithEmail();
                    //  Get.toNamed(PageRoutes.otpVerifyPage);
                  },
                  icon: Image.asset("Assets/Image/forward.png"),
                  iconSize: 72,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
