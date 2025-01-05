import 'package:flutter/material.dart';
import 'package:my_notes/app/image_config.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/model/mood_mapping.dart';

class NotesListItem extends StatelessWidget {
  const NotesListItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.mood,
  });

  final void Function()? onTap;
  final String title;
  final String subtitle;
  final String date;
  final int mood;

  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: Dimens.listItemMarginVertical(),
        padding: Dimens.listItemPadding(),
        decoration: Dimens.containerDecoration(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          height: 1.6,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    formatDate(date),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          height: 1.6,
                          color: theme == Brightness.light
                              ? AppColors.hintTextColor
                              : AppColors.appWhite,
                        ),
                  ),
                ],
              ),
            ),
            horizontalSpace(10),
            Expanded(
              flex: 1,
              child: Image.asset(
                Mood.moodToEmoji(mood),
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
