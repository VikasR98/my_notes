import 'package:flutter/material.dart';
class DefaultAppBarTitle extends StatelessWidget {
  final String title;
  const DefaultAppBarTitle({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const  EdgeInsets.only(left: 10.0),
      child: Text(
        title,
      ),
    );
  }
}
