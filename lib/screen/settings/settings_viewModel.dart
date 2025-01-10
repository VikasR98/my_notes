import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  bool _darkModeSwitchVal = false;

  bool get darkModeSwitchVal => _darkModeSwitchVal;

  set darkModeSwitchVal(bool value) {
    _darkModeSwitchVal = value;
    notifyListeners();
  }

  bool _bioMatricSwitchVal = true;

  bool get bioMatricSwitchVal => _bioMatricSwitchVal;

  set bioMatricSwitchVal(bool value) {
    _bioMatricSwitchVal = value;
    notifyListeners();
  }

  File ? _profileImage;

  File? get profileImage => _profileImage;

  set profileImage(File? value) {
    _profileImage = value;
    notifyListeners();
  }

  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // setState(() {
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
      return MaterialStateProperty.all(
        AppColors.inactiveSwitchTrackColor,
      );
    }
    return MaterialStateProperty.all(
      AppColors.primaryColor,
    );
  }

  getThumbColor(final theme) {
    if (theme == Brightness.light) {
      return MaterialStateProperty.all(
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
}
