import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Helper/PageRoute.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String isLogin;

  WebViewPage({Key? key, required this.url,required this.isLogin}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
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
            }else{
              Get.toNamed(PageRoutes.signupPage);
            }
            },
            icon: Image.asset("Assets/Image/Arrow_left.png"),
          ),
             title: Text("Privacy Policy", style: TextStyles.size18Medium),
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

