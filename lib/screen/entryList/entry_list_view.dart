import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/main.dart';
import 'package:my_notes/screen/entryList/localWidgets/add_note_btn.dart';
import 'package:my_notes/screen/entryList/localWidgets/notes_list_body.dart';
import 'package:my_notes/screen/entryList/entry_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class EntryListView extends StatefulWidget {
  const EntryListView({super.key});

  @override
  State<EntryListView> createState() => _EntryListViewState();
}

class _EntryListViewState extends State<EntryListView> with RouteAware {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This will be called both when first creating the widget and when returning to it
    log("didChangeDependencies called entry list");
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // This is called when returning to the current route after another route has been popped
    log("didPopNext called");
  }

  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel){
        // Store the ViewModel in a local variable
        // _viewModel = viewModel;
        log('entry viewmodel');
        // viewModel.deleteDiaryEntry(id:11);
        viewModel.getAllEntries();
      },
      viewModelBuilder: () => EntryListViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            // leading: const Padding(
            //   padding: EdgeInsets.only(left: Dimens.padding20),
            //   child: Icon(
            //     Icons.book,
            //     size: Dimens.iconSize50,
            //   ),
            // ),
            // title: const Text('Logo'),
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
          floatingActionButton:  AddEntryBtn(viewModel: viewModel,),
          body: NotesListBody(
            viewModel: viewModel,
            theme: theme,

          ),
        );
      },
    );
  }
}
