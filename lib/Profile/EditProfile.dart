import 'dart:io';
import 'package:Trime/Helper/ApiManager/ApiManager.dart';
import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/Utils/common_utils.dart';
import 'package:Trime/Helper/Utils/regx.dart';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Helper/ApiManager/Url.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String userName = "";
  String UserEmail = "";
  String imagePath = "";
  String imageChange = "";
  String fileurl = "";
  String phoneNumber = "";
  dynamic profileImage;
  bool indicator = true;
  late File imageFile;
  PickedFile? pickedFile;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    getProfile().whenComplete(() => setState(() {}));
  }

  setImage() async {
    setState(() {
      if (pickedFile != null) {
        // isImageFileNotEmpty = true;
        imageFile = File(pickedFile!.path);
        // profileImage = FileImage(imageFile);
        imagePath = imageFile.path;
        profileImage = FileImage(imageFile);
        // profileImage = 1;
      }
    });
  }

  showPickerOption() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: const Text(
              "Take Photo From",
              style: TextStyle(color: Colors.red),
            )),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() async {
                      pickedFile = await ImagePicker.platform.pickImage(
                          source: ImageSource.gallery, imageQuality: 20);
                      setImage();
                      Navigator.pop(context);
                    });
                  },
                  icon: Icon(
                    Icons.photo_library,
                    color: HexColors.blueColor,
                  ),
                  iconSize: 60,
                ),
                IconButton(
                  onPressed: () {
                    setState(() async {
                      pickedFile = await ImagePicker.platform.pickImage(
                          source: ImageSource.camera, imageQuality: 20);
                      setImage();
                      Navigator.pop(context);
                    });
                  },
                  icon: Icon(
                    Icons.photo_camera,
                    color: HexColors.blueColor,
                  ),
                  iconSize: 60,
                )
              ],
            ),
          );
        });
  }

  Future<void> getProfile() async {
    var id = await sharePrefrence.getString("userId");
    Map parameter = {
      "query": {"_id": id}
    };
    var result = await ApiManager.getProfile(parameter);

    if (result["status"]) {
      userName = result["response"]["name"];
      name.text = result["response"]["name"];
      email.text = result["response"]["email"];
      var image = result["response"]['image'];
      if (Uri.parse(image).isAbsolute == false) {
        imageChange = Url.ImageUrl + image;
        imagePath = Url.ImageUrl + image;
        profileImage = NetworkImage(Url.ImageUrl + image);
      } else {
        imageChange = image;
        imagePath = image;
        profileImage = NetworkImage(image);
      }
      if (result["response"]['phone'] != null) {
        phone.text = result["response"]['phone'].toString();
      } else {
        phone.text = "";
      }
      // phone = result["response"][["phone"];
      indicator = false;
    } else {
      CommonUtils.toastMessage(result["message"]);
      indicator = false;
    }
  } 

  updateProfile() async {
    if (!regx.regExp.hasMatch(email.text)) {
      CommonUtils.toastMessage("Invalid email");
    } else {
      if (phone.text.isEmpty) {
        var id = await sharePrefrence.getString("userId");

        DateTime dateTime = DateTime.now();
        String time = dateTime.timeZoneName;
        int set = dateTime.timeZoneOffset.inHours;
        Map parameter = {
          "user_id": "$id",
          "name": "${name.text}",
          "phone": "",
          "email": "${email.text}",
          "time_zone": "$time $set"
        };
       
        var result = await ApiManager.updateProfile(parameter);

        if (result["status"]) {
          if (imageChange == imagePath) {
            Get.toNamed(PageRoutes.profilePage);
            CommonUtils.toastMessage(result["message"]);
          } else {
            updateProfileImage();
          }
        } else {
          CommonUtils.toastMessage(result["message"]);
        }
      } else {
        if (phone.text.isNotEmpty) {
          if (!regx.isPhoneNoValid(phone.text)) {
            CommonUtils.toastMessage("Phone Number Should Be 10 Digits");
          } else {
            var id = await sharePrefrence.getString("userId");

            DateTime dateTime = DateTime.now();
            String time = dateTime.timeZoneName;
            int set = dateTime.timeZoneOffset.inHours;
            Map parameter = {
              "user_id": "$id",
              "name": "${name.text}",
              "phone": "${phone.text}",
              "email": "${email.text}",
              "time_zone": "$time $set"
            };
         
            var result = await ApiManager.updateProfile(parameter);

            if (result["status"]) {
              if (imageChange == imagePath) {
                Get.toNamed(PageRoutes.profilePage);
                CommonUtils.toastMessage(result["message"]);
              } else {
                updateProfileImage();
              }
            } else {
              CommonUtils.toastMessage(result["message"]);
            }
          }
        }
      }
    }
  }

  updateProfileImage() async {
    var any = await ApiManager.postUpdateProfileImage(imageFile, imageChange);

    if (any["status"]) {
      CommonUtils.toastMessage(any["message"]);
      print(any["message"]);
      Get.toNamed(PageRoutes.profilePage);
    } else {
      Get.toNamed(PageRoutes.profilePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: TrimeAppBarWithTitle(context, true)
          .getAppBarWithBackArrowTitle("Edit Profile", onBack: () {
        Get.back();
      }),
      body: indicator
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                const SizedBox(
                  height: 60,
                ),
                 Container(
                       // margin: EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             GestureDetector(
                  onTap: () {
                    showPickerOption();
                  },
                  child:
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: profileImage,
                            )),
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                userName,
                                style: TextStyles.size20Bold,
                              ),
                            ),
                             
                          ],
                        ),
                      ),
                // GestureDetector(
                //   onTap: () {
                //     showPickerOption();
                //   },
                //   child: 
                //  CircleAvatar(
                //               radius: 70,
                //               backgroundImage: profileImage,
                            
                //     // child: Container(
                //     //   height: 180,
                //     //   width: 180,
                //     //   child: IconButton(
                //     //       onPressed: () {
                //     //         showPickerOption();
                //     //       },
                //     //       icon: profileImage),
                //     // ),
                //   ),
                // ),
                // Image.network(profileImage)
                SizedBox(
                  height: 10,
                ),
                // Center(
                //   child: Text(
                //     userName,
                //     style: TextStyles.size20Bold,
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 41),
                  child: const Text(
                    "Name",
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
                    controller: name,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        border: InputBorder.none,
                        hintText: "Enter your name"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 41),
                  child: const Text(
                    "Phone Number",
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
                    controller: phone,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.only(left: 20),
                        border: InputBorder.none,
                        hintText: "Enter phone number"),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.only(left: 41),
                  child: const Text(
                    "Email",
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
                    controller: email,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        border: InputBorder.none,
                        hintText: "Enter your email"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          // if (!regx.isPhoneNoValid(phone.text)) {
                          //   CommonUtils.toastMessage("Invalid Phone Number!");
                          // } else {
                          updateProfile();
                          // }
                        },
                        child:
                            const Text("Save", style: TextStyles.size20Bold)),
                    //const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        // if (!regx.isPhoneNoValid(phone.text)) {
                        //   CommonUtils.toastMessage("Invalid Phone Number!");
                        // } else {
                        updateProfile();
                        // }
                      },
                      icon: Image.asset("Assets/Image/forward.png"),
                      iconSize: 72,
                    )
                  ],
                ),
              ],
            ),
    ));
  }
}
