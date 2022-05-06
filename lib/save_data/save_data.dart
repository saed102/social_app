import 'package:shared_preferences/shared_preferences.dart';

class savedata {
  static late SharedPreferences save;

  static init() async {
    return save = await SharedPreferences.getInstance();
  }

  static Future<bool> put_isdark(key, value) async {
    return await save.setBool(key, value);
  }
 
  static Future get_isdark(key)async {
    return await save.getBool(key);
  }

  static Future set_uid(key, value) async {
    return await save.setString(key, value);
  }

  static Future get_uid(key) async {
    return await save.getString(key);
  }
  static Future remove_uid(key) async {
    return await save.remove("uid").then((value) {
      print("done");
    });
  }
}
