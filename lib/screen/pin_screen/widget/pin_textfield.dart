import 'package:flutter/material.dart';
import 'package:my_notes/widgets/app_textformfield_new.dart';

class PinTextField extends StatelessWidget {
  const PinTextField({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.onChanged,
  });

  final FocusNode focusNode;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 50,
      child: AppTextFormFieldNew(
        enabled: false,
        focusNode: focusNode,
        maxLength: 1,
        centerTextHorizontal: true,
        contentPadding: const EdgeInsets.all(5),
        textEditingController: controller,
        onChanged: onChanged,
      ),
    );
  }
}
