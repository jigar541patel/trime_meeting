import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../Helper/style/styles.dart';

class linkswebview extends StatefulWidget {
  final String url;
  final String isLogin;

  linkswebview({Key? key, required this.url, required this.isLogin})
      : super(key: key);

  @override
  State<linkswebview> createState() => _linkswebviewState();
}

class _linkswebviewState extends State<linkswebview> {
   bool isLoading=true;

  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset("Assets/Image/Arrow_left.png"),
        ),
        title: Text("Links", style: TextStyles.size18Medium),
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
