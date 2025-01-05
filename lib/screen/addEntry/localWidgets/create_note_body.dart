import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';

class MoodEmojiWidget extends StatelessWidget {
  const MoodEmojiWidget({
    super.key,
    required this.iconName,
    required this.onTap,
    required this.value,
    required this.selectedValue,
  });

  final String iconName;
  final void Function() onTap;

  final int value;
  final int selectedValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 25,
        backgroundColor:
            value == selectedValue ? AppColors.primaryColor : Colors.white,
        child: Image.asset(iconName),
      ),
    );
  }
}
