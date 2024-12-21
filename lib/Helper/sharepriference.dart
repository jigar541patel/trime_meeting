import 'package:shared_preferences/shared_preferences.dart';

class sharePrefrence {
  static saveString(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static getString(Key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Key);
  }

   static getBool(Key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Key);
  }

    static saveBool(key, value ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key,value);
  }


  static removeString(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
