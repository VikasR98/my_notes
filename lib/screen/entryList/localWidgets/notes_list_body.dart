import 'package:flutter/material.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/screen/entryList/localWidgets/notes_list_item.dart';
import 'package:my_notes/screen/entryList/localWidgets/search_widget.dart';
import 'package:my_notes/screen/entryList/entry_list_viewmodel.dart';

class NotesListBody extends StatelessWidget {
  const NotesListBody({
    super.key,
    required this.theme,
    required this.viewModel,
  });

  final Brightness theme;
  final EntryListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: Dimens.appScreenPadding(),
          child: Search(theme: theme),
        ),
        Expanded(
          child: ListView.builder(
            // reverse: true,
            padding: Dimens.appScreenPaddingHorizontal(),
            physics: const BouncingScrollPhysics(),
            itemCount: viewModel.entries?.length ?? 0,
            itemBuilder: (context, index) {
              final data = viewModel.entries?[index];
              return NotesListItem(
                onTap: (){
                  viewModel.onItemTap(context: context, entry: data);
                },
                title: data?.title ?? '',
                subtitle: data?.description ?? '',
                date: data?.dateTime ?? '',
                mood: data?.mood ?? 0,
              );
            },
          ),
        )
      ],
    );
  }
}
