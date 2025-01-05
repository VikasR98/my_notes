import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/widgets/app_textformfield_new.dart';
class Search extends StatelessWidget {
  const Search({
    super.key,
    required this.theme,
  });

  final Brightness theme;

  @override
  Widget build(BuildContext context) {
    return AppTextFormFieldNew(
      fillColor: theme == Brightness.light
          ? AppColors.appWhite
          : AppColors.darkModeSecondaryColor,
      hintText: 'Search Entries',
      suffixIcon: Icon(
        Icons.search_rounded,
        color: theme == Brightness.light
            ? AppColors.hintTextColor
            : AppColors.appWhite,
      ),
    );
  }
}
