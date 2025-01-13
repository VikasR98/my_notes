import 'package:flutter/material.dart';
import 'package:my_notes/service/locator.dart';
import 'package:my_notes/service/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    _loadTheme();
  }

  final _sharedPrefs = locator<SharedPreferencesService>();

  Future<void> _loadTheme() async {
    _isDarkTheme = _sharedPrefs.getDarkTheme() ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _isDarkTheme = isDark;
    _sharedPrefs.setDarkTheme(isDark);
    notifyListeners();
  }
}
