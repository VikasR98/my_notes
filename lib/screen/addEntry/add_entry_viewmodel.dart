import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/databse_helper/data_base_helper.dart';
import 'package:my_notes/model/data_entry.dart';
import 'package:my_notes/model/mood_mapping.dart';
import 'package:stacked/stacked.dart';

class AddEntryViewModel extends BaseViewModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final dbHelper = DatabaseHelper();



  insertNewEntry({required DiaryEntry entry, required context}) async {
    int id = await dbHelper.insertDiaryEntry(entry);
    if (kDebugMode) {
      print('Inserted entry with ID: $id');
    }
    titleController.clear();
    descriptionController.clear();
    selectedValue = 0;
    Navigator.pop(context);
    notifyListeners();
  }


  updateEntry() async {
    // Update an entry
    // entry.title = "My Updated Entry";
    // entry.description = "This is an updated description.";
    // entry.mood = Mood.sad;
    // await dbHelper.updateDiaryEntry(entry);
  }

  deleteEntry(int id) async {
    // Delete an entry
    await dbHelper.deleteDiaryEntry(id);
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
  }
}
