import 'package:flutter/material.dart';
import 'package:my_notes/app/image_config.dart';
import 'package:my_notes/screen/addEntry/add_entry_viewmodel.dart';
import 'package:my_notes/screen/addEntry/localWidgets/create_note_body.dart';

class MoodRowUi extends StatelessWidget {

  final AddEntryViewModel viewModel;
  const MoodRowUi({
    super.key,
    required this.viewModel
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Mood',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              MoodEmojiWidget(
                value: 1,
                selectedValue: viewModel.selectedValue,
                onTap: () {
                  viewModel.selectedValue = 1;
                  // viewModel.selectedMood = 'happinessEmoji';
                },
                iconName: laugh,
              ),
              MoodEmojiWidget(
                value: 2,
                selectedValue: viewModel.selectedValue,
                onTap: () {
                  // setState(() {
                  viewModel.selectedValue = 2;
                  // viewModel.selectedMood = 'neutralEmoji';
                  // });
                  // print('netral');
                },
                iconName: happy,
              ),
              MoodEmojiWidget(
                value: 3,
                selectedValue: viewModel.selectedValue,
                onTap: () {
                  viewModel.selectedValue = 3;
                  // viewModel.selectedMood = 'confusedEmoji';
                },
                iconName: normal,
              ),
              MoodEmojiWidget(
                value: 4,
                selectedValue: viewModel.selectedValue,
                onTap: () {
                  viewModel.selectedValue = 4;
                  // viewModel.selectedMood = 'signEmoji';
                  // print('sign');
                },
                iconName: sad,
              ),
              MoodEmojiWidget(
                value: 5,
                selectedValue: viewModel.selectedValue,
                onTap: () {
                  // setState(() {
                  viewModel.selectedValue = 5;
                  //   viewModel.selectedMood = 'sadEmoji';
                  // });
                },
                iconName: cry,
              ),
            ],
          )
        ],
      ),
    );
  }
}
