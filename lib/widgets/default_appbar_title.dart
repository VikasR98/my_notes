import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultAppBarTitle extends StatelessWidget {
  final String title;

  const DefaultAppBarTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        title,
        style: GoogleFonts.poppins().copyWith(
          fontWeight: FontWeight.bold,
          // fontSize: 30
        ),
      ),
    );
  }
}
