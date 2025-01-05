import 'package:flutter/material.dart';
import 'package:my_notes/constants/dimes.dart';

class EditIcon extends StatelessWidget {
  final IconData iconData;
  final void Function() onTap;

  const EditIcon({
    super.key,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        iconData,
        size: Dimens.iconSize45,
      ),
    );
  }
}
