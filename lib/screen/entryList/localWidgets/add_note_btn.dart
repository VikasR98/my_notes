import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/screen/addEntry/add_entry_view.dart';
import 'package:my_notes/screen/addEntry/add_entry_viewmodel.dart';
import 'package:my_notes/screen/entryList/entry_list_viewmodel.dart';

class AddEntryBtn extends StatelessWidget {
  final EntryListViewModel viewModel;

  const AddEntryBtn({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          addEntryRoute,
        ).then((value) {
          viewModel.getAllEntries();
        });
      },
      child: const CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.primaryColor,
        child: Icon(
          Icons.edit_note_rounded,
          size: 35,
          color: AppColors.appWhite,
        ),
      ),
    );
  }
}
