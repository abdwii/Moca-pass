import 'dart:ui';

import 'package:svg_flutter/svg.dart';

import '../../utility/assets_data.dart';
import '../../utility/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../utility/theme.dart';

class SecondaryCustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final String iconPath;
  final Color? color;
  final Color? textColor;

  const SecondaryCustomButton({
    super.key,
    required this.text,
    required this.iconPath,
    this.color,
    this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var isTablet = deviceType == DeviceScreenType.tablet ||
        deviceType == DeviceScreenType.desktop;
    return MaterialButton(
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      shape: const StadiumBorder(),
      onPressed: () {
        onPressed();
      },
      color: color ?? kSecondaryColor,
      textColor: textColor ?? primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 8.sw, vertical: 2.5.sw),
      child: Row(
        children: [
          const Spacer(
            flex: 3,
          ),
          SvgPicture.asset(
            iconPath,
            colorFilter: kColorFilter(primaryColor),
          ),
          const Spacer(
            flex: 1,
          ),
          Text(text, style: secondaryCustomButtonTextStyle(isTablet)),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
