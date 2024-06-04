import '../../utility/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MainCustomButton extends StatelessWidget {
  final String buttonName;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool isEnabled;

  const MainCustomButton({
    super.key,
    required this.buttonName,
    required this.isEnabled,
    required this.onPressed,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      disabledColor: kHintColor,
      shape: const StadiumBorder(),
      onPressed: isEnabled ? onPressed : null,
      color: backgroundColor ?? Colors.white,
      textColor: primaryColor,
      padding: padding,
      child: Text(
        buttonName,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: backgroundColor == primaryColor
                ? kSecondaryColor
                : primaryColor,
            fontSize: 3.sw),
      ),
    );
  }
}
