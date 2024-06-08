import '../../core/utility/colors_data.dart';
import '../../core/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

final themeData = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true),
    scaffoldBackgroundColor: primaryColor,
    textTheme: const TextTheme(
        labelLarge: TextStyle(
      color: Colors.white,
      fontSize: 64,
      fontFamily: StringConst.mainFont,
      fontWeight: FontWeight.w500,
    )),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          TextStyle(
            color: primaryColor,
            fontSize: 48,
            fontFamily: StringConst.mainFont,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStatePropertyAll(0),
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        foregroundColor: MaterialStatePropertyAll(Colors.black),
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
        shape: MaterialStatePropertyAll(StadiumBorder()),
      ),
    ),
    fontFamily: StringConst.mainFont);

final textFormFieldBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30.sw),
  borderSide: const BorderSide(width: 1.5, color: Colors.white),
);
final textFormFieldErrorBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30.sw),
  borderSide: const BorderSide(width: 1.5, color: kErrorColor),
);

EdgeInsetsGeometry getLoginHPadding(
    bool isTablet, Orientation deviceOrientation) {
  if (isTablet && Orientation.portrait == deviceOrientation) {
    return EdgeInsets.symmetric(horizontal: 28.sw);
  } else if (isTablet && Orientation.landscape == deviceOrientation) {
    return EdgeInsets.symmetric(horizontal: 50.sw);
  } else {
    return EdgeInsets.symmetric(horizontal: 6.sw);
  }
}

EdgeInsetsGeometry getMainHPadding(
    bool isTablet, Orientation deviceOrientation) {
  if (isTablet && Orientation.portrait == deviceOrientation) {
    return EdgeInsets.symmetric(horizontal: 25.sw);
  } else if (isTablet && Orientation.landscape == deviceOrientation) {
    return EdgeInsets.symmetric(horizontal: 40.sw);
  } else {
    return EdgeInsets.symmetric(horizontal: 6.sw);
  }
}

TextStyle textInputsLabelStyle() {
  return const TextStyle(
      color: Colors.white,
      fontFamily: StringConst.mainFont,
      fontWeight: FontWeight.w400,
      fontSize: 18);
}

TextStyle secondaryCustomButtonTextStyle(bool isTablet) {
  return TextStyle(
      color: primaryColor,
      fontFamily: StringConst.mainFont,
      fontWeight: FontWeight.w600,
      fontSize: isTablet ? 22 : 20);
}

TextStyle scannerInfoTextStyle(bool isTablet) {
  return TextStyle(
      color: Colors.white,
      fontFamily: StringConst.mainFont,
      fontWeight: FontWeight.w500,
      fontSize: isTablet ? 28 : 20);
}
