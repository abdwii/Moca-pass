import '../../utility/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SecondaryCustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const SecondaryCustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: primaryColor),
          borderRadius: BorderRadius.circular(12)),
      onPressed: () {
        onPressed();
      },
      color: Colors.white,
      textColor: primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 8.sw, vertical: 4.sw),
      child: Row(
        children: [
          const Spacer(),
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          // SvgPicture.asset(
          //   AssetsData.forward,
          //   colorFilter: kColorFilter(primaryColor),
          // ),
        ],
      ),
    );
  }
}
