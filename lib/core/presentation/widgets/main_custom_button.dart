import '../../utility/colors_data.dart';
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
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var isTablet = deviceType == DeviceScreenType.tablet ||
        deviceType == DeviceScreenType.desktop;
    return MaterialButton(
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      disabledColor: kHintColor,
      shape: const StadiumBorder(),
      onPressed: onPressed,
      color: backgroundColor ?? Colors.white,
      textColor: primaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 9.sw : 15.sw,
        vertical: isTablet ? 2.sw : 4.5.sw,
      ),
      child: Text(
        buttonName,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: primaryColor, fontSize: 48),
      ),
    );
  }
}
