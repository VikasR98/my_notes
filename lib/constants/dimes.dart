import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dimens {
  static const padding20 = 20.0;
  static const iconSize50 = 50.0;

  static appTextFormFieldBorderSide(context) {
    return BorderSide(
      width: 0,
      color: Theme.of(context).colorScheme.secondary,
    );
  }

  static listItemMarginVertical() {
    return const EdgeInsets.symmetric(vertical: 8);
  }

  static listItemPadding() {
    return const EdgeInsets.symmetric(horizontal: 18, vertical: 18);
  }

  static containerDecoration(context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: Dimens.appCircularBorderRadius(),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          spreadRadius:2,
          blurRadius: 5,
          offset: Offset(0, 1),
        ),
      ],
    );
  }

  static appScreenPadding() {
    return const EdgeInsets.symmetric(
      horizontal: Dimens.padding20,
      vertical: Dimens.padding20,
    );
  }

  static appScreenPaddingHorizontal() {
    return const EdgeInsets.symmetric(
      horizontal: Dimens.padding20,
    );
  }

  static appCircularBorderRadius() {
    return BorderRadius.circular(16);
  }

  static appDialogBorderRadius() {
    return BorderRadius.circular(24);
  }

  static entryDescriptionBorderRadius() {
    return const Radius.circular(70);
  }

  static textFormFieldBorder(context) {
    return OutlineInputBorder(
      borderSide: Dimens.appTextFormFieldBorderSide(context),
      borderRadius: Dimens.appCircularBorderRadius(),
    );
  }

  TextInputFormatter get alphabeticFormatter =>
      FilteringTextInputFormatter.allow(
        RegExp(r'[a-zA-Z ]'),
      );

  static const double iconSize45 = 45;
}
