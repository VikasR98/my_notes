import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences? _prefs;

  // Initialize the SharedPreferences instance
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get the SharedPreferences instance
  SharedPreferences? get prefs => _prefs;

  // Save an integer value (userId)
  Future<void> setUserId(int userId) async {
    await _prefs?.setInt('userId', userId);
  }
  // Save an integer value (userId)
  Future<void> setDarkTheme(bool isDark) async {
    await _prefs?.setBool('isDark', isDark);
  }

  bool? getDarkTheme() {
    return _prefs?.getBool('isDark');
  }


  // Get an integer value (userId)
  int? getUserId() {
    return _prefs?.getInt('userId');
  }

  // Remove userId (e.g., for logout)
  Future<void> removeUserId() async {
    await _prefs?.remove('userId');
  }

  Future<bool> clearSharedPreferences() async {
    return await _prefs!.clear();
  }
}
