import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _themeKey = 'isDarkTheme';

  // Load the theme preference
  Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false; // Default to light theme
  }

  // Save the theme preference
  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }
}