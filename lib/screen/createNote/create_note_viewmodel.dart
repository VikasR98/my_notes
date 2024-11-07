import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class CreateNoteViewModel extends BaseViewModel {
  String? _lastEditTime;

  String? get lastEditTime => _lastEditTime;

  set lastEditTime(String? value) {
    _lastEditTime = value;
    notifyListeners();
  }
  TextAlign _textAlign = TextAlign.left;

  TextAlign get textAlign => _textAlign;

  set textAlign(TextAlign value) {
    _textAlign = value;
    notifyListeners();
  }

  int  _selectedValue = 0;

  int get selectedValue => _selectedValue;

  set selectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }

  getLastEditTime(DateTime now) {
    lastEditTime = DateFormat('MMM d, h:mm a').format(now);
  }
  String? _selectedMood;

  String ?get selectedMood => _selectedMood;

  set selectedMood(String ?value) {
    _selectedMood = value;
    notifyListeners();
  }
}
