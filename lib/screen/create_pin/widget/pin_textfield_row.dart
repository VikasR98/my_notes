import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';

import 'pin_indicator_ui.dart';

class PinTextFieldsRow extends StatefulWidget {
  const PinTextFieldsRow({
    super.key,
    required this.isFirstFilled,
    required this.isSecondFilled,
    required this.isThirdFilled,
    required this.isFourthFilled,
    required this.firstValue,
    required this.secondValue,
    required this.thirdValue,
    required this.fourthValue,
    required this.showPin,
  });

  final bool isFirstFilled;
  final bool isSecondFilled;
  final bool isThirdFilled;
  final bool isFourthFilled;
  final String firstValue;
  final String secondValue;
  final String thirdValue;
  final String fourthValue;
  final bool showPin;

  @override
  State<PinTextFieldsRow> createState() => _PinTextFieldsRowState();
}

class _PinTextFieldsRowState extends State<PinTextFieldsRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PinIndicatorWidget(
          showPin: widget.showPin,
          isFilled: widget.isFirstFilled,
          value: widget.firstValue,
        ),
        PinIndicatorWidget(
          showPin: widget.showPin,
          isFilled: widget.isSecondFilled,
          value: widget.secondValue,
        ),
        PinIndicatorWidget(
          showPin: widget.showPin,
          isFilled: widget.isThirdFilled,
          value: widget.thirdValue,
        ),
        PinIndicatorWidget(
          showPin: widget.showPin,
          isFilled: widget.isFourthFilled,
          value: widget.fourthValue,
        ),
      ],
    );
  }
}
