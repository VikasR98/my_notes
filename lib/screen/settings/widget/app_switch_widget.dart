import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';

class AppSwitchWidget extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;

  const AppSwitchWidget({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness;
    return Switch(
      activeTrackColor: AppColors.primaryColor,
      thumbColor: getThumbColor(theme),
      inactiveTrackColor: AppColors.inactiveSwitchTrackColor,
      trackOutlineColor: getTrackOutLineColor(),
      value: value,
      onChanged: onChanged,
    );
  }

  getThumbColor(final theme) {
    if (theme == Brightness.light) {
      return WidgetStateProperty.all(
        AppColors.appWhite,
      );
    }
    return WidgetStateProperty.all(
      AppColors.darkModeBgColor,
    );
  }

  getTrackOutLineColor() {
    if (value == false) {
      return WidgetStateProperty.all(
        AppColors.inactiveSwitchTrackColor,
      );
    }
    return WidgetStateProperty.all(
      AppColors.primaryColor,
    );
  }
}
