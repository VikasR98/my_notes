import 'package:stacked/stacked.dart';

class PinScreenViewModel extends BaseViewModel {
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

  enterValue({required String value}) {
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
    notifyListeners();
  }

  void showPin() {
    print(firstChar);
    print(secondChar);
    print(thirdChar);
    print(fourthChar);
  }
}
