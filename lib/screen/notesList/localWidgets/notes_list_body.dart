import 'package:flutter/material.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/screen/notesList/localWidgets/notes_list_item.dart';
import 'package:my_notes/screen/notesList/localWidgets/search_widget.dart';

class NotesListBody extends StatelessWidget {
  const NotesListBody({
    super.key,
    required this.theme,
    required this.onTap,
  });

  final Brightness theme;
  final void Function()? onTap;

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
            padding: Dimens.appScreenPaddingHorizontal(),
            physics: const BouncingScrollPhysics(),
            itemCount: 14,
            itemBuilder: (context, index) {
              return NotesListItem(
                onTap: onTap,
              );
            },
          ),
        )
      ],
    );
  }
}
