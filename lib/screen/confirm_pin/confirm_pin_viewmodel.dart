import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/service/locator.dart';
import 'package:my_notes/service/shared_prefs_service.dart';
import 'package:stacked/stacked.dart';

class ConfirmPinViewModel extends BaseViewModel {
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
      // showPin();
      checkPin(context);
    }
  }

  bool _showPin = false;

  bool get showPin => _showPin;

  set showPin(bool value) {
    _showPin = value;
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

  String pinValueOne = '';

  set fourthFilled(bool value) {
    _fourthFilled = value;
    notifyListeners();
  }

  final _sharedPrefs = locator<SharedPreferencesService>();

  bool _isWrongPin = false;

  bool get isWrongPin => _isWrongPin;

  set isWrongPin(bool value) {
    _isWrongPin = value;
    notifyListeners();
  }

  checkPin(context) {
    String reEnteredPin = '$firstChar$secondChar$thirdChar$fourthChar';
    log('reEnteredPin $reEnteredPin');
    if (pinValueOne == reEnteredPin) {
      log('pin matched');
      _sharedPrefs.setSavedPin(pinValueOne);
      _sharedPrefs.setIsPinEnabled(true);
      Fluttertoast.showToast(
        msg: pinEnableString,
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.pushNamed(context, pinCreateSuccessRoute);
    } else {
      isWrongPin = true;
      clearValues();
      notifyListeners();
      log('pin not matched');
    }
  }
clearValues(){
  firstFilled = false;
  secondFilled = false;
  thirdFilled = false;
  fourthFilled = false;
  firstChar = '';
  secondChar = '';
  thirdChar = '';
  fourthChar = '';
}
  void showEnteredPin() {
    if (kDebugMode) {
      log(firstChar!);
      log(secondChar!);
      log(thirdChar!);
      log(fourthChar!);
    }
  }
}
