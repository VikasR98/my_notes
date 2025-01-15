import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/screen/confirm_pin/confirm_pin_view.dart';
import 'package:my_notes/service/locator.dart';
import 'package:stacked/stacked.dart';

class CreatePinViewModel extends BaseViewModel {
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
      Navigator.pushNamed(
        context,
        confirmPinRoute,
        arguments: ConfirmPinViewArgs(
            pin: '$firstChar$secondChar$thirdChar$fourthChar'),
      );
    }
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
}
