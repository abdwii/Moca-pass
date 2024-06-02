import '../../core/utility/colors_data.dart';
import '../../core/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

final themeData = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true),
  scaffoldBackgroundColor: primaryColor,
  textTheme: const TextTheme(labelLarge:  TextStyle(
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
      shape: MaterialStatePropertyAll( StadiumBorder()),
    ),
  ),
  fontFamily: StringConst.mainFont
);

final textFormFieldBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30.sw),
  borderSide: const BorderSide(width: 1.5, color: kDividerColor),
);



TextStyle textInputsLabelStyle() {
  return TextStyle(
      color: Colors.white,
      fontFamily: StringConst.mainFont,
      fontWeight: FontWeight.w300,
      fontSize: 2.sw);
}