import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.onTap,
    required this.btnText,
    this.bgColor = AppColors.primaryColor,
  });

  final void Function()? onTap;
  final String btnText;
  Color ?bgColor ;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(240, 50),
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: onTap,
      child: Text(
        btnText,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.appWhite,
            ),
      ),
    );
  }
}
