import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_notes/databse_helper/data_base_helper.dart';
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
  // import 'dart:io';
  // import 'package:image_picker/image_picker.dart';

  Future<void> registerUser() async {
    // final picker = ImagePicker();
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // String name = "John Doe";
    // String email = "john.doe@example.com";
    // String password = "password123"; // Make sure to hash the password in a real app

    // if (pickedFile != null) {
    //   final File imageFile = File(pickedFile.path);
    //   await DatabaseHelper().saveUserProfile(
    //     name: name,
    //     email: email,
    //     password: password,
    //     imageFile: imageFile,
    //   );
    //   print("User profile saved successfully.");
    // } else {
      // Save without image
    // try {
      await DatabaseHelper().saveUserProfile(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      userRegistered = true;
      notifyListeners();
    // } catch(e) {
    //   log(e.toString());
    // }

    // print('value: $value');
      log("User profile saved successfully without image.");
    // }
  }

}
