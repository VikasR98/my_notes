import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/enum/form_action.dart';
import 'package:my_notes/model/data_entry.dart';
import 'package:my_notes/screen/addEntry/add_entry_viewmodel.dart';

class SaveButtonUi extends StatelessWidget {
  final AddEntryViewModel viewModel;

  const SaveButtonUi({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Dimens.padding20),
      child: GestureDetector(
        onTap: () {
          if (viewModel.formAction == FormAction.add) {
            _insertNewEntry(context);
          } else if (viewModel.formAction == FormAction.edit) {
            _updateEntry(context);
          }
        },
        child: const Icon(
          Icons.save,
          size: Dimens.iconSize50,
        ),
      ),
    );
  }

  _updateEntry(BuildContext context) {
    if (viewModel.titleController.text.isEmpty &&
        viewModel.descriptionController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter title or description');
      return;
    }
    if(viewModel.selectedValue == 0){
      Fluttertoast.showToast(msg: 'Please select mood');
      return;
    }
    viewModel.updateEntry(
      context: context,
      entry: DiaryEntry(
        id: viewModel.id,
        title: viewModel.titleController.text,
        description: viewModel.descriptionController.text,
        dateTime: convertToFullDateTime(viewModel.lastEditTime ?? ''),
        mood: viewModel.selectedValue,
      ),
    );
  }

  void _insertNewEntry(BuildContext context) {
    if (viewModel.titleController.text.isEmpty &&
        viewModel.descriptionController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter title or description');
      return;
    }
    if(viewModel.selectedValue == 0){
      Fluttertoast.showToast(msg: 'Please select mood');
      return;
    }
    viewModel.insertNewEntry(
      context: context,
      entry: DiaryEntry(
        title: viewModel.titleController.text,
        description: viewModel.descriptionController.text,
        dateTime: DateTime.now().toString(),
        mood: viewModel.selectedValue,
      ),
    );
  }
}
