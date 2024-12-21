import 'package:Trime/Helper/ApiManager/ApiManager.dart';
import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/Utils/SizeConfig.dart';
import 'package:Trime/Helper/Utils/common_utils.dart';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Helper/ApiManager/Url.dart';

class ProfilePage extends StatefulWidget {
  String id = "";

  ProfilePage({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // late ProfileModel result;
  String userName = "";
  String UserEmail = "";
  String phone = "";
  dynamic profileImage;
  bool indicator = true;

  @override
  void initState() {
    super.initState();
    getProfile().whenComplete(() => setState(() {}));
  }

  Future<void> getProfile() async {
    var id = await sharePrefrence.getString("userId");
    Map parameter = {
      "query": {"_id": id}
    };

    var result = await ApiManager.getProfile(parameter);
    if (result["status"]) {
      // CommonUtils.toastMessage(response[Strings.message]);
      userName = result["response"]["name"];
      UserEmail = result["response"]["email"];
      String image = result["response"]['image'];
      var value = image.substring(0, 4);

      if (value != "http") {
        profileImage = NetworkImage(Url.ImageUrl + image);

        //https://app.trime.ai/user/avatar_1653731709755.jpg

      } else {
        profileImage = NetworkImage(image);
      }
      if (result["response"]['phone'] != null) {
        phone = result["response"]['phone'].toString();
      } else {
        phone = "";
      }

      indicator = false;
    } else {
      CommonUtils.toastMessage(result["message"]);
      indicator = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: TrimeAppBarWithTitle(context, false)
            .getAppBarWithBackArrowTitle("My Profile", onBack: () {
          Get.back();
        }),
        body: indicator
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(width: 60),
                      Container(
                        margin: EdgeInsets.only(left: 50),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: profileImage,
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                userName,
                                style: TextStyle(
                                    fontFamily: "inter,Bold",
                                    fontSize:
                                        SizeConfig.blockSizeVertical! * 3.0,
                                    color: Color(0xFF000000)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 22),
                      Container(
                        margin: EdgeInsets.only(
                          top: 80,
                        ),
                        child: IconButton(
                            onPressed: () {
                              Get.toNamed(PageRoutes.editPage);
                            },
                            icon: Image.asset("Assets/Image/profile edit.png")),
                      )
                    ],
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),

                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: SizeConfig.blockSizeHorizontal!*1.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "Email",
                            style: TextStyle(
                                fontFamily: "inter,Bold",
                                fontSize: SizeConfig.safeBlockVertical! * 1.8,
                                color: Color(0xffBEBEBE)),
                          ),
                          SizedBox(height: 10),
                          Text(UserEmail,
                              style: TextStyle(
                                  fontFamily: "inter,regular",
                                  fontSize: SizeConfig.safeBlockVertical! * 1.8,
                                  color: Color(0xff252629))),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Phone Number",
                            style: TextStyle(
                                fontFamily: "inter,Bold",
                                fontSize: SizeConfig.safeBlockVertical! * 1.8,
                                color: Color(0xffBEBEBE)),
                          ),
                          SizedBox(height: 10),
                          Text(phone,
                              style: TextStyle(
                                  fontFamily: "inter,regular",
                                  fontSize: SizeConfig.safeBlockVertical! * 1.8,
                                  color: Color(0xff252629))),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                sharePrefrence.removeString("token");
                                sharePrefrence.removeString("isLogin");
                                //sharePrefrence.removeString("FCM Token");

                                Get.toNamed(PageRoutes.loginPage);
                                CommonUtils.toastMessage("Logout successful");
                              },
                              child: Text("LogOut",
                                  style: TextStyle(
                                      fontFamily: "inter,Bold",
                                      fontSize:
                                          SizeConfig.blockSizeVertical! * 2.5,
                                      color: Color(0xFF000000)))),
                        ],
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: Size.zero, padding: EdgeInsets.zero),
                          onPressed: () {
                            Get.toNamed(PageRoutes.changePass);
                          },
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                                fontFamily: "inter,Bold",
                                fontSize: SizeConfig.safeBlockVertical! * 1.8,
                                color: Color(0xffBEBEBE)),
                          ))
                    ],
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(left: 15),
                  //   child: Row(
                  //     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       // TextButton(
                  //       //     onPressed: () {
                  //       //       sharePrefrence.removeString("token");
                  //       //       sharePrefrence.removeString("isLogin");
                  //       //       Get.toNamed(PageRoutes.loginPage);
                  //       //       CommonUtils.toastMessage("Logout successful");
                  //       //     },
                  //       //     child: const Text("LogOut",
                  //       //         style: TextStyles.size20Bold)),
                  //       //const SizedBox(width: 3),
                  //       // IconButton(
                  //       //   onPressed: () {
                  //       //      sharePrefrence.removeString("token");
                  //       //       Get.toNamed(PageRoutes.loginPage);
                  //       //        CommonUtils.toastMessage("Logout successful");
                  //       //   },
                  //       //   icon: Image.asset("Assets/Image/logout.png"),
                  //       //   iconSize: 72,
                  //       // )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Get.toNamed(PageRoutes.homePage);
              },
              icon: Image.asset(
                "Assets/Image/Home-new.png",
              ),
              iconSize: 55,
            ),
            SizedBox(
              width: 50,
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(PageRoutes.profilePage);
              },
              icon: Image.asset(
                "Assets/Image/SettingTab.png",
                color: Colors.blue,
              ),
              iconSize: 55,
            )
          ],
        ),
      ),
    );
  }
}
