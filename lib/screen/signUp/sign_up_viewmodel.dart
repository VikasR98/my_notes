import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/databse_helper/data_base_helper.dart';
import 'package:my_notes/model/auth_result.dart';
import 'package:my_notes/service/auth_service.dart';
import 'package:my_notes/service/locator.dart';
import 'package:my_notes/service/shared_prefs_service.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? _show = true;
  AutovalidateMode _validateMode = AutovalidateMode.disabled;

  AutovalidateMode get validateMode => _validateMode;

  set validateMode(AutovalidateMode value) {
    _validateMode = value;
    notifyListeners();
  }

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

  bool _userRegistered = false;

  bool get userRegistered => _userRegistered;

  set userRegistered(bool value) {
    _userRegistered = value;
    notifyListeners();
  }

  isAllValueFilled() {
    if (nameController.text.isEmpty) {
      allValComplete = false;
      return;
    }
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

  bool loading = false;
  bool get getLoading => this.loading;

  set setLoading(bool loading) {
    this.loading = loading;
    notifyListeners();
  }

  final sharedPrefs = locator<SharedPreferencesService>();
  addUserToLocalDb(AuthResult result) async {
    try {
      final db = await DatabaseHelper().database;
      await db.insert(DatabaseHelper.tableUserProfile, {
        'uid': result.user?.uid,
        'name': nameController.text.trim(),
        'email': result.user?.email,
        'profile_image_path': '',
        'created_at': DateTime.now().millisecondsSinceEpoch,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      });
      if (kDebugMode) {
        log('User data add to user_profile table');
      }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "Insert error - User creation");
    }
  }

  Future<void> registerUser(context) async {
    setBusy(true);

    AuthResult result = await AuthService().signUp(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setBusy(false);

    if (result.isSuccess) {
      // ❌ triggering UI elements from viewmodel/changenotifier is violation
      // of separation of concern, not testable
      /// move it to UI file
      Fluttertoast.showToast(
        msg: 'Auto signing in...',
        toastLength: Toast.LENGTH_LONG,
      );
      sharedPrefs.setUserId(result.user?.uid ?? '');
      await addUserToLocalDb(result);
      userRegistered = true;
      Navigator.of(context).pushNamedAndRemoveUntil(
        entryListRoute,
        (route) => false,
      );
      // print("user.displayName: ${user.displayName}");
    } else {
      // ❌ triggering UI elements from viewmodel/changenotifier is violation
      // of separation of concern, not testable
      /// move it to UI file
      Fluttertoast.showToast(msg: result.error.toString());
      if (kDebugMode) {
        log("User not created");
      }
    }

    // if (await isUser()) {
    //   Fluttertoast.showToast(msg: "Email already exists");
    // } else {
    //   await DatabaseHelper().registerUser(
    //     name: nameController.text.trim(),
    // email: emailController.text.trim(),
    // password: passwordController.text.trim(),
    //   );
    //
    //   notifyListeners();
    //   log("User profile saved successfully without image.");
    // }
  }
}
