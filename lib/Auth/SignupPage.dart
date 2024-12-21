import 'package:Trime/Helper/ApiManager/ApiManager.dart';
import 'package:Trime/Helper/ApiManager/Modals/Registration.dart';
import 'package:Trime/Helper/ApiManager/Url.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/Utils/SizeConfig.dart';
import 'package:Trime/Helper/Utils/common_utils.dart';
import 'package:Trime/Helper/Utils/regx.dart';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:Trime/webpages/service_webpage.dart';
import 'package:Trime/webpages/terms&conditions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool ischeck = false;
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  TextEditingController phone = TextEditingController();
  late registrationModal result;
  final _formKey = GlobalKey<FormState>();

  registration() async {
    Map parameters = {
      "name": name.text,
      "email": email.text,
      "password": password.text,
      "confirm_password": confirmPass.text,
      "phone": phone.text,
      "referred_from": ""
    };
    var url = Url.registerApi;

    if (name.text.isEmpty) {
      CommonUtils.toastMessage("Name is Required?");
    } else if (!regx.nameRegExp.hasMatch(name.text)) {
      CommonUtils.toastMessage("Invalid Name!");
    } else if (email.text.isEmpty) {
      CommonUtils.toastMessage("Email is Required?");
    } else if (!regx.regExp.hasMatch(email.text)) {
      CommonUtils.toastMessage("Invalid Email!");
    }
    // else if (phone.text.isEmpty) {
    //   CommonUtils.toastMessage("Phone Number is Required?");
    // }

    else if (password.text.isEmpty) {
      CommonUtils.toastMessage("Password is Required?");
    } else if (regx.validatePassword(password.text) != null) {
      CommonUtils.toastMessage(
          "Password must be Atleast 1 Uppercase,1 Lowercase,1 Spical Case And Longer Than 8 Character");
    } else if (confirmPass.text.isEmpty) {
      CommonUtils.toastMessage("Confirm Password is Required?");
    } else if (regx.validatePassword(confirmPass.text) != null) {
      CommonUtils.toastMessage(
          "Confrom Password must be Atleast 1 Uppercase,1 Lowercase,1 Spical Case And Longer Than 8 Character");
    } else {
      if (phone.text.isEmpty) {
        if (password.text == confirmPass.text) {
          if (ischeck == true) {
            var result = await ApiManager.registrationApi(parameters);
            if (result!.status! == true) {
              dynamic isSingup =
                  await sharePrefrence.saveBool("isSingup", true);
              CommonUtils.toastMessage("User signup successfully");
              Get.toNamed(PageRoutes.loginPage);
            } else {
              CommonUtils.toastMessage("Email is already exist");
            }
          } else {
            CommonUtils.toastMessage("Please Accept Terms and Conditions");
          }
        } else {
          CommonUtils.toastMessage("Confirm Password is not match");
        }
      } else {
        if (phone.text.isNotEmpty) {
          if (!regx.isPhoneNoValid(phone.text)) {
            CommonUtils.toastMessage("Phone Number Should Be 10 Digits");
          } else {
            if (password.text == confirmPass.text) {
              if (ischeck == true) {
                var result = await ApiManager.registrationApi(parameters);
                if (result!.status! == true) {
                  dynamic isSingup =
                      await sharePrefrence.saveBool("isSingup", true);
                  CommonUtils.toastMessage("User signup successfully");
                  Get.toNamed(PageRoutes.loginPage);
                } else {
                  CommonUtils.toastMessage("Email is already exist");
                }
              } else {
                CommonUtils.toastMessage("Please Accept Terms and Conditions");
              }
            }
          }
        }
      }
      //    if (password.text == confirmPass.text) {
      //     var result = await ApiManager.registrationApi(parameters);
      //     Get.toNamed(PageRoutes.loginPage);
      // } else {
      //   CommonUtils.toastMessage("Confirm Password is not match");
      // }
    }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
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
                      "Sign Up to continue",
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
            // Stack(
            //   children: [
            //     Container(
            //       height: 251,
            //       width: MediaQuery.of(context).size.width * 2,
            //       color: HexColors.blueColor,
            //     ),
            //     Positioned(
            //         top: 35,
            //         right: 20,
            //         child: Image.asset("Assets/Image/logo.png")),
            //     Positioned(
            //         top: 55,
            //         right: -120,
            //         bottom: 5,
            //         child: Image.asset("Assets/Image/calendar.png")),
            //     // Positioned(
            //     //     top: 25,
            //     //     left: 30,
            //     //     child: Image.asset("Assets/Image/Group 2427.png")),
            //     Positioned(
            //         bottom: 45,
            //         left: 14,
            //         child: Text(
            //           "Make Awesome Meetings",
            //           style: TextStyle(
            //               fontFamily: "inter,medium",
            //               fontSize: SizeConfig.safeBlockVertical! * 3.6,
            //               color: Color(0xffFFFFFF)),
            //         )),
            //     Positioned(
            //         bottom: 15,
            //         left: 14,
            //         child: Text(
            //           "Sign Up to continue",
            //           style: TextStyle(
            //               fontFamily: "inter,medium",
            //               fontSize: SizeConfig.safeBlockVertical! * 3.2,
            //               color: Color(0xffFFFFFF)),
            //           // style: TextStyles.whiteSubTitleTextStyle,
            //         ))
            //   ],
            // ),
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
                        "Name *",
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
                        controller: name,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical! * 2.3,
                            ),
                            hintText: "Enter your full name"),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.only(left: 41),
                      child: Text(
                        "Email *",
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
                        controller: email,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical! * 2.3,
                            ),
                            hintText: "Enter your Email"),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.only(left: 41),
                      child: Text(
                        "Phone No.",
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
                        controller: phone,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.only(left: 20),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical! * 2.3,
                            ),
                            hintText: "Enter your Number"),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.only(left: 41),
                      child: Text(
                        "Password *",
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
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 20, top: 16),
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
                            hintStyle: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical! * 2.3,
                            ),
                            hintText: "Enter your Password"),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.only(left: 41),
                      child: Text(
                        "Confirm Password *",
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
                        controller: confirmPass,
                        obscureText: confirmPasswordVisible,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(left: 20, top: 16),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    confirmPasswordVisible =
                                        !confirmPasswordVisible;
                                  });
                                },
                                icon: confirmPasswordVisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)),
                            hintStyle: TextStyle(
                              fontSize: SizeConfig.safeBlockVertical! * 2.3,
                            ),
                            hintText: "Re Enter Password"),
                      ),
                    ),
                  ],
                )),
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
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Checkbox(
                    value: ischeck,
                    onChanged: (value) {
                      setState(() {
                        ischeck = !ischeck;
                      });
                    }),
                const Text(
                  "I accept",
                  style: TextStyles.size12Light,
                ),
                TextButton(
                    onPressed: () {
                      Get.to(termsandconditions(
                        url: Url.termsconditionUrl,
                        isLogin: '',
                      ));
                    },
                    child: const Text("terms and conditions",
                        style: TextStyle(
                            color: HexColors.blueColor,
                            fontFamily: "intel,Light",
                            fontSize: 12))),
                const Text("and", style: TextStyles.size12Light),
                TextButton(
                    onPressed: () {
                      Get.to(WebViewPage(
                        url: Url.privacypolicyUrl,
                        isLogin: '',
                      ));
                    },
                    child: const Text("privacy policy.",
                        style: TextStyle(
                            color: HexColors.blueColor,
                            fontFamily: "intel,Light",
                            fontSize: 12))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      registration();
                    },
                    child: Text("Sign up",
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockVertical! * 3.0,
                            fontFamily: "inter,Bold",
                            color: Color(0xFF000000)))),
                //const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    registration();
                  },
                  icon: Image.asset("Assets/Image/forward.png"),
                  iconSize: 52,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a User?",
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockVertical! * 2.8,
                        fontFamily: "intel,Light",
                        color: Color(0xffBEBEBE))),
                TextButton(
                    onPressed: () {
                      Get.toNamed(PageRoutes.loginPage);
                    },
                    child:  Text("Signin Here",
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockVertical! * 2.3,
                          fontFamily: "intel,Light",
                          color: HexColors.blueColor,
                        )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
