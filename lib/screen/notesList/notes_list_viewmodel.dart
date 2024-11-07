import 'package:flutter/material.dart';
import 'package:my_notes/screen/notesList/localWidgets/notes_list_dialog.dart';
import 'package:stacked/stacked.dart';

class NotesListViewModel extends BaseViewModel {
  onItemTap(context)async {
  var result =  await showDialog(
    barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return const NotesListDialog();
      },
    );
  }
  goToSettings(context){
    Navigator.pushNamed(context, '/settingsRoute');
  }
}
