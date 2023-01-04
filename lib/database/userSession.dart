import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userSaveSession {
  static SharedPreferences? _preferences;
  static const _currentUserId = "currentUserId";

  static Future init() async {
  _preferences ??= await SharedPreferences.getInstance();}

  static Future setCurrentUserId(int user_id) async {
    
      await _preferences!.setInt(_currentUserId, user_id);}
  static int? getUserID() => _preferences!.getInt(_currentUserId);


}
