import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/databse_helper/data_base_helper.dart';
import 'package:my_notes/enum/entry_options.dart';
import 'package:my_notes/enum/form_action.dart';
import 'package:my_notes/model/data_entry.dart';
import 'package:my_notes/model/mood_mapping.dart';
import 'package:my_notes/screen/addEntry/add_entry_view.dart';
import 'package:my_notes/screen/entryList/localWidgets/notes_list_dialog.dart';
import 'package:stacked/stacked.dart';

class EntryListViewModel extends BaseViewModel {
  final dbHelper = DatabaseHelper();

  onItemTap({
    required BuildContext context,
    required DiaryEntry? entry,
  }) async {
    var result = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return const NotesListDialog();
      },
    );
    switch (result) {
      case NotesOptions.view:
        if (context.mounted) {
          Navigator.pushNamed(
            context,
            viewEntryRoute,
            arguments: entry,
          ).then(
            (value) {
              log('i am here view');
              getAllEntries();
            },
          );
        }
        break;
      case NotesOptions.edit:
        if (context.mounted) {
          /// Passing arguments like this is cumbersome/complex
          /// it needs context and messy syntax
          Navigator.pushNamed(
            context,
            addEntryRoute,
            arguments: AddEntryArgs(
              entry: entry,
              formAction: FormAction.edit,
            ),
          ).then((value) {
            log('i am here edit');
            getAllEntries();
          });
        }
        break;
      case NotesOptions.delete:
        deleteDiaryEntry(id: entry?.id ?? 0);
        break;
    }
  }

  goToSettings(context) {
    Navigator.pushNamed(context, '/settingsRoute');
  }

  List<DiaryEntry>? _entries;

  List<DiaryEntry>? get entries => _entries;

  set entries(List<DiaryEntry>? entries) {
    _entries = entries;
    notifyListeners();
  }

  getAllEntries() async {
    entries = await dbHelper.getDiaryEntries();
    entries = entries?.reversed.cast<DiaryEntry>().toList();
    notifyListeners();

    for (var entry in entries!) {
      print(
          '${entry.id} - ${entry.title} - ${Mood.moodToEmoji(entry.mood)} at ${entry.dateTime}');
    }
  }

  goToEditEntry({
    required BuildContext context,
    required DiaryEntry entry,
    required FormAction formAction,
  }) {
    Navigator.pushNamed(
      context,
      addEntryRoute,
      arguments: AddEntryArgs(
        formAction: formAction,
        entry: entry,
      ),
    ).then((value) {
      getAllEntries();
    });
  }

  deleteDiaryEntry({required int id}) async {
    await dbHelper.deleteDiaryEntry(id);
    getAllEntries();
  }
}
