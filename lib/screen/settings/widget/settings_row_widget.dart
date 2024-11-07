import 'package:flutter/material.dart';
import 'package:my_notes/constants/sizeExtentions.dart';
class SettingsRow extends StatelessWidget {
  final String label;
  final Widget icon;
  void Function()? onTap;

  SettingsRow({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                label,
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Align(child: icon, alignment: Alignment.centerRight,),
            )
          ],
        ),
      ),
    );
  }
}
