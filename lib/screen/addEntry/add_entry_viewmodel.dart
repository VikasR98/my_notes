import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/databse_helper/data_base_helper.dart';
import 'package:my_notes/enum/form_action.dart';
import 'package:my_notes/model/data_entry.dart';
import 'package:stacked/stacked.dart';

class AddEntryViewModel extends BaseViewModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final dbHelper = DatabaseHelper();

  FormAction? formAction = FormAction.add;

  insertNewEntry({required DiaryEntry entry, required context}) async {
    // int id = await dbHelper.insertDiaryEntry(entry);
    if (kDebugMode) {
      print('Inserted entry with ID: $id');
    }
    titleController.clear();
    descriptionController.clear();
    selectedValue = 0;
    Navigator.pop(context);
  }

  FontWeight _fontWeight = FontWeight.normal;

  FontWeight get fontWeight => _fontWeight;

  set fontWeight(FontWeight value) {
    _fontWeight = value;
    notifyListeners();
  }

  FontStyle _fontStyle = FontStyle.normal;

  int? _id;

  int? get id => _id;

  set id(int? value) {
    _id = value;
    notifyListeners();
  }

  updateEntry({required DiaryEntry entry, required context}) async {
    // await dbHelper.updateDiaryEntry(entry);
    titleController.clear();
    descriptionController.clear();
    selectedValue = 0;
    Navigator.pop(context);
  }



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

  int _selectedValue = 0;

  int get selectedValue => _selectedValue;

  set selectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }

  getLastEditTime(DateTime now) {
    lastEditTime = DateFormat('MMM d, h:mm a').format(now);
    // print(lastEditTime);
  }

  FontStyle get fontStyle => _fontStyle;

  set fontStyle(FontStyle value) {
    _fontStyle = value;
    notifyListeners();
  }


}
