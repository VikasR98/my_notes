import 'package:flutter/material.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/sizeExtentions.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/enum/entry_options.dart';

class NotesListDialog extends StatelessWidget {
  const NotesListDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: Dimens.appDialogBorderRadius(),
      ),
      elevation: 1,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogOption(
              label: viewEntryString,
              iconData: Icons.remove_red_eye,
              onTap: () {
                Navigator.pop(context, NotesOptions.view);
              },
            ),
            verticalSpace(15),
            DialogOption(
              label: editEntryString,
              iconData: Icons.edit,
              onTap: () {
                Navigator.pop(context, NotesOptions.edit);
              },
            ),
            verticalSpace(15),
            DialogOption(
              label: deleteEntryString,
              iconData: Icons.delete,
              onTap: () {
                Navigator.pop(context, NotesOptions.delete);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DialogOption extends StatelessWidget {
  const DialogOption({
    super.key,
    required this.label,
    required this.onTap,
    // required this.icon,?
    required this.iconData,
  });

  final String label;

  // final Icon icon;
  final void Function() onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            iconData,
            size: 25,
            color: getColor(),
          ),
          horizontalSpace(20),
          Text(
            label,
            style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: getColor(),
                ),
          ),
        ],
      ),
    );
  }

  getColor() {
    if (label == deleteEntryString) {
      return Colors.red;
    }
  }
}
