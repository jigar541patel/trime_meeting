

import 'package:fluttertoast/fluttertoast.dart';

class CommonUtils {
  static final CommonUtils _singleton = CommonUtils._internal();

  factory CommonUtils() {
    return _singleton;
  }

  CommonUtils._internal();

 static void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  

  
}
