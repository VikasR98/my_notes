import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences? _prefs;

  String userIdKey = 'userIdKey';
  String isDarkKey = 'isDarkKey';
  String pinKey = 'pinKey';
  String pinEnabledKey = 'pinEnabledKey';

  // Initialize the SharedPreferences instance
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Get the SharedPreferences instance
  SharedPreferences? get prefs => _prefs;

  // Save an integer value (userId)
  Future<void> setUserId(int userId) async {
    await _prefs?.setInt(userIdKey, userId);
  }

  // save pin value
  Future<void> setSavedPin(String pin) async {
    await _prefs?.setString(pinKey, pin);
  }

  // Save an integer value (userId)
  Future<void> setDarkTheme(bool isDark) async {
    await _prefs?.setBool(isDarkKey, isDark);
  }

  // save pin enabled value
  Future<void> setIsPinEnabled(bool pinEnabled) async {
    await _prefs?.setBool(pinEnabledKey, pinEnabled);
  }

  // get pin enabled value
  bool? getIsPinEnabled() {
    return _prefs?.getBool(pinEnabledKey);
  }

  bool? getDarkTheme() {
    return _prefs?.getBool(isDarkKey);
  }

  // get pin key
  String? getSavedPin() {
    return _prefs?.getString(pinKey);
  }

  // Get an integer value (userId)
  int? getUserId() {
    return _prefs?.getInt(userIdKey);
  }

  // Remove userId (e.g., for logout)
  Future<void> removeUserId() async {
    await _prefs?.remove(userIdKey);
  }

  Future<bool> clearSharedPreferences() async {
    return await _prefs!.clear();
  }
}
