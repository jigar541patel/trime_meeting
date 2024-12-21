import 'package:Trime/Helper/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpPage extends StatefulWidget {
  final String url;

  HelpPage({Key? key, required this.url}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
   bool isLoading=true;

  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
           leading: IconButton(
            onPressed: () {
              // Get.toNamed(PageRoutes.homePage);
            },
            icon: Image.asset("Assets/Image/Arrow_left.png"),
          ),
             title: Text("Help", style: TextStyles.size18Medium),
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