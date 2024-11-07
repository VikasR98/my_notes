import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignInViewModel extends BaseViewModel{
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
}