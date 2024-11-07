import 'package:flutter/material.dart';
import 'package:my_notes/constants/dimes.dart';
class DefaultAppBarLeading extends StatelessWidget {
  const DefaultAppBarLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Padding(
        padding: EdgeInsets.only(left: Dimens.padding20),
        child: Icon(
          Icons.arrow_back,
          size: Dimens.iconSize50,
        ),
      ),
    );
  }
}
