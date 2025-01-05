
import 'package:flutter/material.dart';
import 'package:my_notes/screen/addEntry/add_entry_viewmodel.dart';
import 'package:my_notes/screen/addEntry/localWidgets/editing_icon_widget.dart';

class EditTextToolUi extends StatefulWidget {
  final AddEntryViewModel viewModel;
  const EditTextToolUi({
    super.key,
    required this.viewModel
  });

  @override
  State<EditTextToolUi> createState() => _EditTextToolUiState();
}

class _EditTextToolUiState extends State<EditTextToolUi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EditIcon(
            iconData: Icons.format_align_left_rounded,
            onTap: () {
              widget.viewModel.textAlign = TextAlign.left;
            },
          ),
          EditIcon(
            iconData: Icons.format_align_center_rounded,
            onTap: () {
              widget.viewModel.textAlign = TextAlign.center;
            },
          ),
          EditIcon(
            iconData: Icons.format_align_right_rounded,
            onTap: () {
              widget.viewModel.textAlign = TextAlign.right;

              print('align');
            },
          ),
          EditIcon(
            iconData: Icons.format_bold_rounded,
            onTap: () {
              setState(() {
                if (widget.viewModel.fontWeight == FontWeight.w900) {
                  widget.viewModel.fontWeight = FontWeight.normal;
                } else {
                  widget.viewModel.fontWeight = FontWeight.w900;
                }
              });
            },
          ),
          EditIcon(
            iconData: Icons.format_italic_rounded,
            onTap: () {
              setState(() {
                if (widget.viewModel.fontStyle != FontStyle.italic) {
                  widget.viewModel.fontStyle = FontStyle.italic;
                } else {
                  widget.viewModel.fontStyle = FontStyle.normal;
                }
              });
            },
          ),
          EditIcon(
            iconData: Icons.format_underline_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
