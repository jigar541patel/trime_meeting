import 'package:Trime/Helper/ApiManager/ApiManager.dart';
import 'package:Trime/Helper/ApiManager/Modals/Login.dart';
import 'package:Trime/Helper/ApiManager/Url.dart';
import 'package:Trime/Helper/AppBar/TrimeAppBar.dart';
import 'package:Trime/Helper/Color/Colors.dart';
import 'package:Trime/Helper/PageRoute.dart';
import 'package:Trime/Helper/Utils/common_utils.dart';
import 'package:Trime/Helper/Utils/regx.dart';
import 'package:Trime/Helper/sharepriference.dart';
import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ChangePassword extends StatefulWidget {
  ChangePassword({
    Key? key,
  }) : super(key: key);
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}
class _ChangePasswordState extends State<ChangePassword> {
  bool confirmPasswordVisible = true;
  bool oldPasswordVisible = true;
  bool newPasswordVisible = true;
  TextEditingController oldpassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  late loginModel result;
  final _formKey = GlobalKey<FormState>();
  changepassword() async {
    var id = await sharePrefrence.getString("userId");
    Map parameters = {
      "user_id": id,
      "old_password": oldpassword.text,
      "new_password": password.text,
      "confirm_password": confirmpass.text
    };
    var url = Url.changePassword;
   if (oldpassword.text.isEmpty) {
      CommonUtils.toastMessage("Old Password Required?");
    } else if (regx.validatePassword(oldpassword.text) != null) {
      CommonUtils.toastMessage(
          "Old Password must be Atleast 1 Uppercase,1 Lowercase,1 Spical Case And Longer Than 8 Character");
    } else if (password.text.isEmpty) {
      CommonUtils.toastMessage("New Password is Required?");
    } else if (regx.validatePassword(password.text) != null) {
      CommonUtils.toastMessage(
          "New Password must be Atleast 1 Uppercase,1 Lowercase,1 Spical Case And Longer Than 8 Character");
    } else if (confirmpass.text.isEmpty) {
      CommonUtils.toastMessage("Confrom Password is Required?");
    } else if (regx.validatePassword(confirmpass.text) != null) {
      CommonUtils.toastMessage(
          "Confrom Password must be Atleast 1 Uppercase,1 Lowercase,1 Spical Case And Longer Than 8 Character");
    } else {
      if (password.text == confirmpass.text) {
        var result = await ApiManager.changePasswordApi(parameters);
       
        //  Get.toNamed(PageRoutes.profilePage);
        //   CommonUtils.toastMessage(" New Password created!");
        // if(oldpassword ==oldpassword){
        if (result["status"] == true) {
          Get.toNamed(PageRoutes.profilePage);
          CommonUtils.toastMessage(result["message"]);
        } else {
          CommonUtils.toastMessage(result["message"]);
        }

       
      } else {
        CommonUtils.toastMessage("Confirm Password is not match!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TrimeAppBarWithTitle(context, true)
            .getAppBarWithBackArrowTitle("Change Password", onBack: () {
          Get.back();
        }),
        body: ListView(
          children: [
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.only(left: 41),
              child: const Text(
                "Old Password*",
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
                controller: oldpassword,
                obscureText: oldPasswordVisible,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 20, top: 16),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            oldPasswordVisible = !oldPasswordVisible;
                          });
                        },
                        icon: oldPasswordVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    hintText: "Enter Old Password"),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 41),
              child: const Text(
                " New Password*",
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
                controller: password,
                obscureText: newPasswordVisible,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 20, top: 16),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            newPasswordVisible = !newPasswordVisible;
                          });
                        },
                        icon: newPasswordVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    hintText: "Enter New Password"),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 41),
              child: const Text(
                "Confirm Password*",
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
                controller: confirmpass,
                obscureText: confirmPasswordVisible,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 20, top: 16),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            confirmPasswordVisible = !confirmPasswordVisible;
                            // obscure = !obscure;
                          });
                        },
                        icon: confirmPasswordVisible
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                    hintText: "Re Enter Password"),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      changepassword();
                    },
                    child: const Text("Update Password",
                        style: TextStyles.size20Bold)),
                // const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    changepassword();
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
