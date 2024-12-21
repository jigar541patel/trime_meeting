import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Helper/PageRoute.dart';

class termsandconditions extends StatefulWidget {
  final String url;
  final String isLogin;

  termsandconditions({Key? key, required this.url, required this.isLogin})
      : super(key: key);

  @override
  State<termsandconditions> createState() => _termsandconditionsState();
}

class _termsandconditionsState extends State<termsandconditions> {
   bool isLoading=true;

  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            if (widget.isLogin == "true") {
              Get.toNamed(PageRoutes.loginPage);
            } else {
              //Get.toNamed(PageRoutes.signupPage);
              Navigator.pop(context);
            }
          },
          icon: Image.asset("Assets/Image/Arrow_left.png"),
        ),
        title: Text("Term's & Conditions", style: TextStyles.size18Medium),
        centerTitle: true,
      ),
      // appBar:App ,
      body: 
      Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? Center( child: CircularProgressIndicator(),)
                    : Stack(),
        ],
      ),
     
    );
  }
}
