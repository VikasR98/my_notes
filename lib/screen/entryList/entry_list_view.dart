import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_notes/app/image_config.dart';
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

  FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) {
        viewModel.getAllEntries();
      },
      viewModelBuilder: () => EntryListViewModel(),
      builder: (context, viewModel, child) {
        return GestureDetector(
          onTap: () {
            searchFocusNode.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: Dimens.padding20),
                child: Image.asset(
                  diaryThree,
                  height: Dimens.iconSize50,
                  color: theme == Brightness.light
                      ? Colors.black
                      : AppColors.appWhite,
                ),
              ),
              title: Center(
                child: Text(
                  'Diary',
                  style: GoogleFonts.rowdies(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: theme == Brightness.light
                        ? Colors.black
                        : AppColors.appWhite,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: Dimens.padding20),
                  child: GestureDetector(
                    onTap: () {
                      searchFocusNode.unfocus();
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
            floatingActionButton: AddEntryBtn(
              viewModel: viewModel,
            ),
            body: viewModel.isBusy
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : viewModel.entries!.isEmpty
                    ? const NoEntryWidget()
                    : NotesListBody(
                        viewModel: viewModel,
                        theme: theme,
                        focusNode: searchFocusNode,
                      ),
          ),
        );
      },
    );
  }
}

class NoEntryWidget extends StatelessWidget {
  const NoEntryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              nicePen,
              height: 100,
            ),
            Text('Everyday is day one')
          ],
        ),
      );
  }
}
