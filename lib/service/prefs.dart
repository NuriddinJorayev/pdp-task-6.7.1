import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<bool> SaveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", userId);
    return prefs.getKeys().contains("userId");
  }
  static Future<String> LoadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString("userId");
    return res!;
    
  }
  static Future<bool> DeleteUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("userId");
  }
  static Future<bool> isExist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().contains("userId");
  }
}
