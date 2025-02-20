import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const String storedToken = "storedToken";
  static const String userAccessToken = "userAccessToken";
  static const String userId = "userId";
  static const String isLoggedIn = "isLoggedIn";
  static const String savedToken = "savedToken";


  static Future setString(String key, String value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString(key, value);
    return;
  }

  static Future setStringList(String key, List<String> value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setStringList(key, value);
    return;
  }

  static removeString(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.remove(key);
  }

  static Future<List<String>?> getStringList(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getStringList(key);
  }

  static setBoolean(String key, bool value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setBool(key, value);
  }

  static Future<bool?> getBoolean(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getBool(key);
  }

  static setInt(String key, int value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getInt(key);
  }

  static Future<String?> getString(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getString(key);
  }

  static clearAllData() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.clear();
  }

  static Future<bool> containsKey(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.containsKey(key);
  }

  static Future<void> removeKey(String key) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.remove(key);
  }

}
