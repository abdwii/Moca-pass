import 'package:alafein/core/utility/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MainCustomButton extends StatelessWidget {
  final String buttonName;
  final void Function()? onPressed;
  final Color? backgroundColor;

  const MainCustomButton(
      {super.key,
      required this.buttonName,
      required this.onPressed,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      disabledColor: kHintColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: onPressed,
      color: backgroundColor ?? Colors.white,
      textColor: primaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: 20.sw,
        vertical: 6.sw,
      ),
      child: Text(
        buttonName,
        style: GoogleFonts.plusJakartaSans(
            fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}
