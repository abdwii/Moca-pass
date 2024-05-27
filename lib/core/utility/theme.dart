import 'package:alafein/core/utility/colors_data.dart';
import 'package:alafein/core/utility/strings.dart';
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
  timePickerTheme: _timePickerTheme,
  scaffoldBackgroundColor: primaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: const MaterialStatePropertyAll(0),
      backgroundColor: const MaterialStatePropertyAll(Colors.white),
      foregroundColor: const MaterialStatePropertyAll(Colors.black),
      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
      shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
          side: const BorderSide(),
          borderRadius: BorderRadius.circular(20.sw))),
    ),
  ),
);

final textFormFieldBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30.sw),
  borderSide: const BorderSide(width: 1.5, color: kDividerColor),
);

final linkStyle = TextStyle(
    fontFamily: StringConst.formulaFont,
    color: primaryColor,
    fontSize: 3.sw,
    fontWeight: FontWeight.w300);

final termsTextStyle = TextStyle(
    fontFamily: StringConst.formulaFont,
    color: kGreyFontColor,
    fontSize: 3.sw,
    fontWeight: FontWeight.w300);
const descTextStyle = TextStyle(
    fontFamily: StringConst.formulaFont,
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w300);
const descTextGrayStyle = TextStyle(
    fontFamily: StringConst.formulaFont,
    color: kIconGrayColor,
    fontSize: 16,
    fontWeight: FontWeight.w300);

final secondaryTextStyle = TextStyle(
    fontFamily: StringConst.formulaFont,
    color: kGreyFontColor,
    fontSize: 4.sw,
    fontWeight: FontWeight.w300);

const labelStyle = TextStyle(
    color: kHintColor,
    fontFamily: StringConst.formulaFont,
    fontWeight: FontWeight.w300);

final appBarTextStyle = GoogleFonts.abhayaLibre(
  fontSize: 4.sw,
  fontWeight: FontWeight.w700,
);
const homeLabeProfileStyle = TextStyle(
  color: kSemiBlack,
  fontSize: 24,
  fontFamily: StringConst.formulaFont,
  fontWeight: FontWeight.bold,
);

const homeLabelStyle = TextStyle(
  color: kSemiBlack,
  fontSize: 24,
  fontFamily: StringConst.formulaFont,
  fontWeight: FontWeight.bold,
);

const homeLabel2Style = TextStyle(
  color: kSemiBlack,
  fontSize: 20,
  fontFamily: StringConst.formulaFont,
  fontWeight: FontWeight.bold,
);
const personalInfoLabelPrimary = TextStyle(
  color: primaryColor,
  fontSize: 20,
  fontFamily: StringConst.formulaFont,
  fontWeight: FontWeight.w700,
);

const homeLabel3Style = TextStyle(
  color: kSemiBlack,
  fontSize: 14,
  fontFamily: StringConst.formulaFont,
  fontWeight: FontWeight.bold,
);
const homeLabel4Style = TextStyle(
  color: kSemiBlack,
  fontSize: 16,
  fontFamily: StringConst.formulaFont,
  fontWeight: FontWeight.bold,
);
const branchStyle = TextStyle(
  color: kGreyFontColor,
  fontSize: 16,
  fontFamily: StringConst.formulaFont,
  fontWeight: FontWeight.w300,
);
const branchSelectedStyle = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontFamily: StringConst.formulaFont,
  fontWeight: FontWeight.w700,
);
const personalInfoTextStyle = TextStyle(
  color: kSemiBlack,
  fontSize: 18,
  fontFamily: StringConst.formulaFont,
  fontWeight: FontWeight.bold,
);
TextStyle venueProfileTextStyle = GoogleFonts.anton(
  fontWeight: FontWeight.w400,
  color: Colors.black,
  fontSize: 20,
);

const eventcomment = TextStyle(
  color: kSemiBlack,
  fontSize: 14,
  fontFamily: StringConst.formulaFont,
  fontWeight: FontWeight.w300,
);

final _timePickerTheme = TimePickerThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    dayPeriodColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return kSecondaryColor;
        } else {
          return kHintColor.withOpacity(0.25);
        }
      },
    ),
    dialTextColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      },
    ),
    dayPeriodTextColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      },
    ),
    hourMinuteTextColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      },
    ),
    hourMinuteColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        } else {
          return kHintColor.withOpacity(0.25);
        }
      },
    ),
    dialHandColor: primaryColor,
    dialBackgroundColor: kHintColor.withOpacity(0.25));
