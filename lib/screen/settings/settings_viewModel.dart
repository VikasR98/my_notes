import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/databse_helper/data_base_helper.dart';
import 'package:my_notes/service/locator.dart';
import 'package:my_notes/service/shared_prefs_service.dart';
import 'package:my_notes/service/theme_serivce.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  final ThemeService _themeService = ThemeService();
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  SettingsViewModel() {
    _loadTheme();
  }

  // Load theme from SharedPreferences when the app starts
  Future<void> _loadTheme() async {
    _isDarkTheme = await _themeService.loadTheme();
    notifyListeners(); // Notify UI of theme change
  }

  // Toggle theme and save to SharedPreferences
  Future<void> toggleTheme(bool isDark) async {
    _isDarkTheme = isDark;
    notifyListeners(); // Notify UI immediately
    await _themeService.saveTheme(isDark); // Persist the new theme
  }

  // bool _darkModeSwitchVal = false;
  //
  // bool get darkModeSwitchVal => _darkModeSwitchVal;
  //
  // set darkModeSwitchVal(bool value) {
  //   _darkModeSwitchVal = value;
  //   notifyListeners();
  // }

  bool _bioMatricSwitchVal = true;

  bool get bioMatricSwitchVal => _bioMatricSwitchVal;

  set bioMatricSwitchVal(bool value) {
    _bioMatricSwitchVal = value;
    notifyListeners();
  }

  File? _profileImage;

  File? get profileImage => _profileImage;

  set profileImage(File? value) {
    _profileImage = value;
    notifyListeners();
  }

  void pickImage() async {
    getUserProfile();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // setState(() {
      updateUserProfileImage();
      _profileImage = File(pickedFile.path);
      notifyListeners();
      // });
    } else {
      log('No image selected.');
    }
  }

  bool _syncAutoSwitchVal = false;

  bool get syncAutoSwitchVal => _syncAutoSwitchVal;

  set syncAutoSwitchVal(bool value) {
    _syncAutoSwitchVal = value;
    notifyListeners();
  }

  getTrackOutLineColor(bool value) {
    if (value == false) {
      return WidgetStateProperty.all(
        AppColors.inactiveSwitchTrackColor,
      );
    }
    return MaterialStateProperty.all(
      AppColors.primaryColor,
    );
  }

  getThumbColor(final theme) {
    if (theme == Brightness.light) {
      return WidgetStateProperty.all(
        AppColors.appWhite,
      );
    }
    return MaterialStateProperty.all(
      AppColors.darkModeBgColor,
    );
  }

  bool? _syncBusy = false;

  bool? get syncBusy => _syncBusy;

  set syncBusy(bool? value) {
    _syncBusy = value;
    notifyListeners();
  }

  int flag = 1;

  void syncNow() {
    syncBusy = true;
    Timer(const Duration(seconds: 2), () {
      syncBusy = false;
      flag = 2;
    });
  }

  Widget getSyncWidget() {
    if (syncBusy == true) {
      return const CircularProgressIndicator.adaptive(
        // backgroundColor: Colors.red,
        backgroundColor: AppColors.primaryColor,
        strokeWidth: 10,
        // strokeWidth: 5,
      );
    } else {
      if (flag == 1) {
        return const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 30,
          // weight: 1,
        );
      }
      return const Icon(
        Icons.check,
        size: 30,
      );
    }
  }

  final sharedPrefs = locator<SharedPreferencesService>();

  void logout(BuildContext context) async {
    setBusy(true);
    bool isCleared = await sharedPrefs.clearSharedPreferences();
    setBusy(false);
    if (isCleared) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, welcomeRoute);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Logout process incomplete. Please try again.");
    }
  }

  final dbHelper = DatabaseHelper();

  Future<Map<String, dynamic>?> getUserProfile() async {
    return await dbHelper.getUserProfile(sharedPrefs.getUserId() ?? 0);
  }

  // updateUserProfileImage() async {

  setProfileImage() async {
    final Map<String, dynamic>? userProfile =
        await dbHelper.getUserProfile((sharedPrefs.getUserId() ?? 0));
    if (userProfile == null) {
      throw Exception('User profile not found');
    }

    final profileImagePath = userProfile['profile_image_path'];
    if (profileImagePath != null) {
      final profileImageFile = File(profileImagePath);

      if (await profileImageFile.exists()) {
        _profileImage = profileImageFile;
      } else {
        log('Profile image file not found at $profileImagePath. Using default image.');
        // Set a default image or leave _profileImage as null
        _profileImage = null; // Or set it to a fallback asset
      }
    } else {
      log('Profile image path is null');
      // Set a default image or leave _profileImage as null
      _profileImage = null; // Or set it to a fallback asset
    }
    notifyListeners();
  }

  Future<void> updateUserProfileImage() async {
    try {
      // Fetch user profile
      final userId = sharedPrefs.getUserId() ?? 0;
      if (userId == 0) {
        throw Exception('Invalid user ID');
      }

      final Map<String, dynamic>? userProfile =
          await dbHelper.getUserProfile(userId);
      if (userProfile == null) {
        throw Exception('User profile not found');
      }

      // Update user profile
      int? updatedId = await dbHelper.updateUser(
        name: userProfile['name'],
        email: userProfile['email'],
        imageFile: profileImage,
        password: userProfile['password'],
      );

      if (updatedId != null) {
        Fluttertoast.showToast(msg: "Profile image updated successfully");
        log('User profile updated successfully for ID: $updatedId');
      } else {
        log('Failed to update user profile.');
      }
    } catch (e) {
      log('Error updating user profile image: $e');
    }
  }

// void toggleTheme(bool isDark) async {
//   await sharedPrefs.setDarkTheme(isDark);
//
//   darkModeSwitchVal = isDark;
// }
}
