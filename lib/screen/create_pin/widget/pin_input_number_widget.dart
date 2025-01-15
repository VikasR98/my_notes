import 'package:flutter/material.dart';
import 'package:my_notes/constants/sizeExtentions.dart';

class PinInputNumberWidget extends StatelessWidget {
  String? label;
  final void Function()? onTap;
  Widget? icon;

  PinInputNumberWidget({
    super.key,
    this.label,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(1),
        height: 40,
        width: 40,
        // color: Colors.red,
        child: icon ??
            Center(
              child: Text(
                label ?? '',
                style: context.displayMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
      ),
    );
  }
}
