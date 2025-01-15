import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/sizeExtentions.dart';

class PinIndicatorWidget extends StatelessWidget {
  const PinIndicatorWidget({
    super.key,
    required this.isFilled,
    required this.value,
    required this.showPin,
  });

  final bool isFilled;
  final String value;
  final bool showPin;

  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(20),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: isFilled == true
          ? Center(
              child: Stack(
                children: [
                  if (showPin == false) ...[
                    Container(
                      // height: 100,
                      // height: 20,
                      // width: 20,
                      decoration: BoxDecoration(
                        color: theme == Brightness.light
                            ? AppColors.darkModeBgColor
                            : AppColors.appWhite,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    )
                  ],
                  if (showPin == true) ...[
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Text(
                        value,
                        textAlign: TextAlign.center,
                        style: context.bodyMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme == Brightness.light
                              ? AppColors.darkModeBgColor
                              : AppColors.appWhite,
                        ),
                      ),
                    )
                  ]
                ],
              ),
            )
          : Container(),
    );
  }
}
