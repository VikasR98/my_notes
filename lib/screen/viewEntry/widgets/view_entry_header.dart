import 'package:flutter/material.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/model/data_entry.dart';
import 'package:my_notes/model/mood_mapping.dart';

class ViewEntryHeaderUi extends StatelessWidget {
  const ViewEntryHeaderUi({
    super.key,
    required this.entry,
  });

  final DiaryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                Text(
                  formatDateTime(entry.dateTime),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                Mood.moodToEmoji(entry.mood),
                height: 90,
              ),
            ),
          )
        ],
      ),
    );
  }
}
