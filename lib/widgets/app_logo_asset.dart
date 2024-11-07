import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';

class AppLogoAsset extends StatelessWidget {
  const AppLogoAsset({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo_transparent.png',
      color: AppColors.primaryColor,
      height: MediaQuery.of(context).size.height * 0.4,
    );
  }
}
