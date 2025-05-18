import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/screen/entryList/entry_list_viewmodel.dart';
import 'package:my_notes/widgets/app_textformfield_new.dart';

class Search extends StatefulWidget {
  const Search({
    super.key,
    required this.theme,
    required this.viewModel,
    required this.focusNode,
  });

  final Brightness theme;
  final EntryListViewModel viewModel;
  final FocusNode focusNode;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = '';
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppTextFormFieldNew(
      textEditingController: searchController,
      focusNode: widget.focusNode,
      onChanged: (String value) {
        setState(() {
          query = value;
          log('query length ${query.length}');
        });
        widget.viewModel.searchDiaryEntries(query: value);
        if (value.isEmpty) {
          widget.viewModel.getAllEntries();
        }
      },
      fillColor: widget.theme == Brightness.light
          ? AppColors.appWhite
          : AppColors.darkModeSecondaryColor,
      hintText: 'Search Entries',
      suffixIcon: query.isEmpty
          ? Icon(
              Icons.search_rounded,
              color: widget.theme == Brightness.light
                  ? AppColors.hintTextColor
                  : AppColors.appWhite,
            )
          : GestureDetector(
              onTap: () {
                widget.focusNode.unfocus();
                setState(() {
                  query = '';
                  searchController.clear();
                });
                widget.viewModel.getAllEntries();
              },
              child: Icon(
                Icons.clear,
                color: widget.theme == Brightness.light
                    ? AppColors.hintTextColor
                    : AppColors.appWhite,
              ),
            ),
    );
  }
}
