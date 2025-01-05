import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';

class DescriptionTextField extends StatelessWidget {
  DescriptionTextField({
    super.key,
    required this.onChanged,
    required this.textAlign,
    required this.fontWeight,
    required this.fontStyle,
    required this.controller,
  });

  void Function(String) onChanged;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;
    return TextFormField(
      controller: controller,
      textAlign: textAlign,
      onChanged: onChanged,
      maxLines: null,
      minLines: null,
      expands: true,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            height: 1.4,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
          ),
      cursorColor: AppColors.primaryColor,
      decoration: const InputDecoration(
        hintText: 'Enter Description',
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(
          top: 50,
          left: 30,
          right: 30,
        ),
      ),
    );
  }
}
