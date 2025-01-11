import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/databse_helper/data_base_helper.dart';
import 'package:my_notes/service/locator.dart';
import 'package:my_notes/service/shared_prefs_service.dart';
import 'package:stacked/stacked.dart';

class SignInViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? _show = true;

  bool? get show => _show;

  set show(bool? value) {
    _show = value;
    notifyListeners();
  }

  void toggleText() {
    show = !show!;
  }

  bool _allValComplete = false;

  bool get allValComplete => _allValComplete;

  set allValComplete(bool value) {
    _allValComplete = value;
    notifyListeners();
  }

  isMailValid() {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text.trim());
    return emailValid;
  }

  AutovalidateMode _formAutoValidate = AutovalidateMode.disabled;

  AutovalidateMode get formAutoValidate => _formAutoValidate;

  set formAutoValidate(AutovalidateMode value) {
    _formAutoValidate = value;
    notifyListeners();
  }

  bool _userRegistered = false;

  bool get userRegistered => _userRegistered;

  set userRegistered(bool value) {
    _userRegistered = value;
    notifyListeners();
  }

  isAllValueFilled() {
    if (emailController.text.isEmpty) {
      allValComplete = false;
      return;
    }
    if (passwordController.text.isEmpty) {
      allValComplete = false;
      return;
    }
    allValComplete = true;
    return;
  }

  Future<bool> isUser() async {
    return await DatabaseHelper().checkUserExistence(
      email: emailController.text.trim(),
    );
  }

  final sharedPrefs = locator<SharedPreferencesService>();

  Future<void> login(
    context,
  ) async {
    if (await isUser()) {
      int? isUserId = await DatabaseHelper().login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (isUserId != null) {
        sharedPrefs.setUserId(isUserId);

        Navigator.of(context).pushNamedAndRemoveUntil(
          entryListRoute,
          (route) => false,
        );
      } else {
        Fluttertoast.showToast(msg: "Invalid credentials");
      }
    } else {
      Fluttertoast.showToast(msg: "Email does not exist");
    }
  }
// import 'dart:io';

// Future<void> displayUserProfile() async {
//   final userProfile = await DatabaseHelper().getUserProfile();
//
//   if (userProfile != null) {
//     print("Name: ${userProfile['name']}");
//     print("Email: ${userProfile['email']}");
//     print("pass: ${userProfile['password']}");
//
//     String? imagePath = userProfile['profile_image_path'];
//     if (imagePath != null && File(imagePath).existsSync()) {
//       // Use Image.file to display the profile image
//       // return Image.file(File(imagePath));
//     } else {
//       print("No profile image found.");
//     }
//   } else {
//     print("No user profile found.");
//   }
// }
}
