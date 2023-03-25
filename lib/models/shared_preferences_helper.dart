import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_week_6_storages/models/user_model.dart';

class SharedPreferencesHelper {
  static const String _keyUser = 'user';

  static Future<SharedPreferences> getInstance() async =>
      await SharedPreferences.getInstance();

  static Future<void> saveUser(UserModel user) async {
    final SharedPreferences prefs = await getInstance();
    final String json = jsonEncode(user.toJson());
    prefs.setString(_keyUser, json);
  }

  static Future<UserModel?> getUser() async {
    final SharedPreferences prefs = await getInstance();
    final String? json = prefs.getString(_keyUser);
    if (json != null) {
      final Map<String, dynamic> map = jsonDecode(json);
      return UserModel.fromJson(map);
    }
    return null;
  }

  static Future<bool> removeUser() async {
    final SharedPreferences prefs = await getInstance();
    return prefs.remove(_keyUser);
  }
}
