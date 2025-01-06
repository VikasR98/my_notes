import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/widgets/app_textformfield_new.dart';

class EntryHeader extends StatelessWidget {
  const EntryHeader({
    super.key,
    required this.theme,
    required this.lastEditTime,
    required this.onChanged,
    required this.titleController,
  });

  final Brightness theme;
  final String? lastEditTime;
  final void Function(String p1) onChanged;
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: theme == Brightness.light
            ? AppColors.appWhite
            : AppColors.darkModeSecondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lastEditTime != null
              ? FittedBox(
                child: Text(
                    lastEditTime ?? '',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                  ),
              )
              : Container(),
          AppTextFormFieldNew(
            textEditingController: titleController,
            hintText: 'Enter Title',
            hintStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                ),
            minLines: 1,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontWeight: FontWeight.w800),
            hideBorder: true,
            fillColor: Colors.transparent,
            onChanged: onChanged,
            removeContentPadding: true,
          ),
        ],
      ),
    );
  }
}
