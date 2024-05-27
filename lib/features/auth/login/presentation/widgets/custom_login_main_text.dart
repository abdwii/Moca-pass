import 'package:alafein/core/utility/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomLoginMainText extends StatelessWidget {
  final String text;
  const CustomLoginMainText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ubuntu(
          fontWeight: FontWeight.w500, color: kSecondaryFontColor, fontSize: 14),
    );
  }
}
