import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/screen/entryList/localWidgets/add_note_btn.dart';
import 'package:my_notes/screen/entryList/localWidgets/notes_list_body.dart';
import 'package:my_notes/screen/entryList/entry_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class NotesListView extends StatefulWidget {
  const NotesListView({super.key});

  @override
  State<NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel){
        viewModel.getAllEntries();
      },
      viewModelBuilder: () => NotesListViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: const Padding(
              padding: EdgeInsets.only(left: Dimens.padding20),
              child: Icon(
                Icons.book,
                size: Dimens.iconSize50,
              ),
            ),
            title: const Text('Logo'),
            actions: [
              Padding(
                padding:const EdgeInsets.only(right: Dimens.padding20),
                child: GestureDetector(
                  onTap: () {
                    viewModel.goToSettings(context);
                  },
                  child: const Icon(
                    Icons.settings,
                    size: Dimens.iconSize50,
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: const AddEntryBtn(),
          body: NotesListBody(
            viewModel: viewModel,
            theme: theme,

          ),
        );
      },
    );
  }
}
