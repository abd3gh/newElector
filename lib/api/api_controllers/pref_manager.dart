import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  Future<bool> set(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      return await prefs.setInt(key, value);
    } else if (value is double) {
      return await prefs.setDouble(key, value);
    } else if (value is String) {
      return await prefs.setString(key, value);
    } else if (value is bool) {
      return await prefs.setBool(key, value);
    }
    return false;
  }

  Future<dynamic> get(String key, dynamic defaultVal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return prefs.get(key);
    }
    return defaultVal;
  }

  Future<bool> contains(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  saveData(String m) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved', m);
  }
  Future<String> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('saved') ?? '';
  }
//اضافة كتابع
  saveFollowerData(String m) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('SavedFollower', m);
  }
  Future<String> getSavedFollowerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('SavedFollower') ?? '';
  }

  saveWithData(String m) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedWith', m);
  }
  Future<String> getWithData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('savedWith') ?? '';
  }
  setName(m)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', m);
  }

  getName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('name') ?? '';
  }
}
