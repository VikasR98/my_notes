import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/databse_helper/data_base_helper.dart';
import 'package:my_notes/screen/confirm_pin/confirm_pin_view.dart';
import 'package:my_notes/service/locator.dart';
import 'package:my_notes/service/shared_prefs_service.dart';
import 'package:stacked/stacked.dart';

class AppLockPinViewModel extends BaseViewModel {
  String? firstChar;
  String? secondChar;
  String? thirdChar;
  String? fourthChar;

  bool _firstFilled = false;

  bool get firstFilled => _firstFilled;

  set firstFilled(bool value) {
    _firstFilled = value;
    notifyListeners();
  }

  bool _secondFilled = false;
  bool _thirdFilled = false;
  bool _fourthFilled = false;

  bool _showPin = false;

  bool get showPin => _showPin;

  set showPin(bool value) {
    _showPin = value;
    notifyListeners();
  }

  enterValue({required String value, required BuildContext context}) {
    if (firstFilled == false) {
      firstFilled = true;
      firstChar = value;
    } else if (secondFilled == false) {
      secondFilled = true;
      secondChar = value;
    } else if (thirdFilled == false) {
      thirdFilled = true;
      thirdChar = value;
    } else if (fourthFilled == false) {
      fourthFilled = true;
      fourthChar = value;

      matchPin(context);
    }
  }

  matchPin(context) {
    String savedPin = sharedPrefs.getSavedPin() ?? '';

    if (savedPin == '$firstChar$secondChar$thirdChar$fourthChar') {
      Navigator.pushReplacementNamed(context, entryListRoute);
    } else {
      //clear all the values
      firstFilled = false;
      secondFilled = false;
      thirdFilled = false;
      fourthFilled = false;
      firstChar = '';
      secondChar = '';
      thirdChar = '';
      fourthChar = '';
      isShowIncorrectPinMsg = true;
      notifyListeners();
    }
  }

  bool _isShowIncorrectPinMsg = false;

  bool get isShowIncorrectPinMsg => _isShowIncorrectPinMsg;

  set isShowIncorrectPinMsg(bool value) {
    _isShowIncorrectPinMsg = value;
    notifyListeners();
  }

  backButton() {
    if (fourthFilled == true) {
      fourthFilled = false;
      fourthChar = '';
    } else if (thirdFilled == true) {
      thirdFilled = false;
      thirdChar = '';
    } else if (secondFilled == true) {
      secondFilled = false;
      secondChar = '';
    } else {
      firstFilled = false;
      firstChar = '';
    }
  }

  bool get secondFilled => _secondFilled;

  set secondFilled(bool value) {
    _secondFilled = value;
    notifyListeners();
  }

  bool get thirdFilled => _thirdFilled;

  set thirdFilled(bool value) {
    _thirdFilled = value;
    notifyListeners();
  }

  bool get fourthFilled => _fourthFilled;

  set fourthFilled(bool value) {
    _fourthFilled = value;
    log('fourth filled');
    notifyListeners();
  }

  void showEnteredPin() {
    print(firstChar);
    print(secondChar);
    print(thirdChar);
    print(fourthChar);
  }

  File? _profileImage;

  File? get profileImage => _profileImage;

  set profileImage(File? value) {
    _profileImage = value;
    notifyListeners();
  }

  final dbHelper = DatabaseHelper();
  final sharedPrefs = locator<SharedPreferencesService>();

  String? userName;

  // setUserName(){
  //
  //   userName = sharedPrefs.get();
  //
  // }

  setProfileImage() async {
    final Map<String, dynamic>? userProfile =
        await dbHelper.getUserProfile((sharedPrefs.getUserId() ?? 0));

    if (userProfile == null) {
      throw Exception('User profile not found');
    }

    userName = userProfile['name'];

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
}
