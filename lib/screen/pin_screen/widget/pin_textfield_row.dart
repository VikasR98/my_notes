import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/screen/pin_screen/pin_screen_view.dart';
import 'package:my_notes/screen/pin_screen/pin_screen_viewmodel.dart';
import 'package:my_notes/screen/pin_screen/widget/pin_textfield.dart';

class PinTextFieldsRow extends StatefulWidget {
  final PinScreenViewModel viewModel;

  const PinTextFieldsRow({
    super.key,
    required this.viewModel,
    // required this.firstFocusNode,
    // required this.firstController,
  });

  @override
  State<PinTextFieldsRow> createState() => _PinTextFieldsRowState();
}

class _PinTextFieldsRowState extends State<PinTextFieldsRow> {
  // final FocusNode firstFocusNode;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PinIndicatorWidget(isFilled: widget.viewModel.firstFilled),
        PinIndicatorWidget(isFilled: widget.viewModel.secondFilled),
        PinIndicatorWidget(isFilled: widget.viewModel.thirdFilled),
        PinIndicatorWidget(isFilled: widget.viewModel.fourthFilled),
      ],
    );
  }
}

class PinIndicatorWidget extends StatelessWidget {
  const PinIndicatorWidget({
    super.key,
    required this.isFilled,
  });

  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(20),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: isFilled == true
          ? Container(
              decoration: BoxDecoration(
                color: theme == Brightness.light
                    ? AppColors.darkModeBgColor
                    : AppColors.appWhite,
                borderRadius: BorderRadius.circular(50),
              ),
            )
          : Container(),
    );
  }
}
