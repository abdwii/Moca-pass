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
    color: Colors.white,
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
/////////////////////////////////////////////////////////
  TextStyle theQuick_brown_fox_jumps_over_the_lazy_dog = TextStyle(
  fontSize: 11,
  fontWeight: getWeightFromString("medium"),
  height: 1.2000000476837158,
);

  TextStyle heading1_regular = TextStyle(
  fontSize: 32,
  fontWeight: getWeightFromString("regular"),
  height: 1.2000000476837158,
);

  TextStyle heading1_medium = TextStyle(
  fontSize: 32,
  fontWeight: getWeightFromString("medium"),
  height: 1.2000000476837158,
);

  TextStyle heading1bold = TextStyle(
  fontSize: 32,
  fontWeight: getWeightFromString("bold"),
  height: 1.2000000476837158,
);

  TextStyle heading2_regular = TextStyle(
  fontSize: 28,
  fontWeight: getWeightFromString("regular"),
  height: 1.2000000476837158,
);

  TextStyle heading2_medium = TextStyle(
  fontSize: 28,
  fontWeight: getWeightFromString("medium"),
  height: 1.2000000476837158,
);

  TextStyle heading2bold = TextStyle(
  fontSize: 28,
  fontWeight: getWeightFromString("bold"),
  height: 1.2000000476837158,
);

  TextStyle heading3_regular = TextStyle(
  fontSize: 25,
  fontWeight: getWeightFromString("regular"),
  height: 1.2000000476837158,
);

  TextStyle heading3_medium = TextStyle(
  fontSize: 25,
  fontWeight: getWeightFromString("medium"),
  height: 1.2000000476837158,
);

  TextStyle heading3bold = TextStyle(
  fontSize: 25,
  fontWeight: getWeightFromString("bold"),
  height: 1.2000000476837158,
);

  TextStyle heading4regular = TextStyle(
  fontSize: 22,
  fontWeight: getWeightFromString("regular"),
  height: 1.2000000476837158,
);

  TextStyle heading4medium = TextStyle(
  fontSize: 22,
  fontWeight: getWeightFromString("medium"),
  height: 1.2000000476837158,
);

  TextStyle heading4bold = TextStyle(
  fontSize: 22,
  fontWeight: getWeightFromString("bold"),
  height: 1.2000000476837158,
);

  TextStyle heading5_regular = TextStyle(
  fontSize: 20,
  fontWeight: getWeightFromString("regular"),
  height: 1.2000000476837158,
);

  TextStyle heading5_medium = TextStyle(
  fontSize: 20,
  fontWeight: getWeightFromString("medium"),
  height: 1.2000000476837158,
);

  TextStyle heading5bold = TextStyle(
  fontSize: 20,
  fontWeight: getWeightFromString("bold"),
  height: 1.2000000476837158,
);

  TextStyle bodySmall_regular = TextStyle(
  fontSize: 14,
  fontWeight: getWeightFromString("regular"),
  height: 1.2000000476837158,
);

  TextStyle bodySmall_medium = TextStyle(
  fontSize: 14,
  fontWeight: getWeightFromString("medium"),
  height: 1.2000000476837158,
);

  TextStyle bodySmallbold = TextStyle(
  fontSize: 14,
  fontWeight: getWeightFromString("bold"),
  height: 1.2000000476837158,
);

  TextStyle captionLarge__regular = TextStyle(
  fontSize: 12,
  fontWeight: getWeightFromString("regular"),
  height: 1.2000000476837158,
);

  TextStyle captionLarge__medium = TextStyle(
  fontSize: 12,
  fontWeight: getWeightFromString("medium"),
  height: 1.2000000476837158,
);

  TextStyle captionLargebold = TextStyle(
  fontSize: 12,
  fontWeight: getWeightFromString("bold"),
  height: 1.2000000476837158,
);

  TextStyle captionSmallregular = TextStyle(
  fontSize: 11,
  fontWeight: getWeightFromString("regular"),
  height: 1.2000000476837158,
);

  TextStyle captionSmallmedium = TextStyle(
  fontSize: 11,
  fontWeight: getWeightFromString("medium"),
  height: 1.2000000476837158,
);

  TextStyle captionSmallbold = TextStyle(
  fontSize: 11,
  fontWeight: getWeightFromString("bold"),
  height: 1.2000000476837158,
);

  TextStyle bodyLargeregular = TextStyle(
  fontSize: 18,
  fontWeight: getWeightFromString("regular"),
  height: 1.2000000476837158,
);

  TextStyle bodyLargemedium = TextStyle(
  fontSize: 18,
  fontWeight: getWeightFromString("medium"),
  height: 1.2000000476837158,
);

  TextStyle bodyLargebold = TextStyle(
  fontSize: 18,
  fontWeight: getWeightFromString("bold"),
  height: 1.2000000476837158,
);

  TextStyle bodyMediumregular = TextStyle(
  fontSize: 16,
  fontWeight: getWeightFromString("regular"),
  height: 1.2000000476837158,
);

  TextStyle bodyMediummedium = TextStyle(
  fontSize: 16,
  fontWeight: getWeightFromString("medium"),
  height: 1.2000000476837158,
);

  TextStyle bodyMediumbold = TextStyle(
  fontSize: 16,
  fontWeight: getWeightFromString("bold"),
  height: 1.2000000476837158,
);

  TextStyle popbodyMediummedium = TextStyle(
  fontSize: 16,
  fontWeight: getWeightFromString("medium"),
  height: 1.2000000476837158,
);

  TextStyle popbodyMediumsemi_bold = TextStyle(
  fontWeight: getWeightFromString("semibold"),
  color: Colors.white,
  height: 1.2000000476837158,
);

////// CHANGE YOUR FONT WEIGHT ACCORDINGLY
 FontWeight getWeightFromString(String weight) {
switch (weight) {
case "thin":
case "thin-italic":
return FontWeight.w100;
case "extra-light":
case "extra-light-italic":
return FontWeight.w200;
case "light":
case "light-italic":
return FontWeight.w300;
case "regular":
case "regular-italic":
return FontWeight.w400;
case "medium":
case "medium-italic":
return FontWeight.w500;
case "semi-bold":
case "semi-bold-italic":
return FontWeight.w600;
case "bold":
case "bold-italic":
return FontWeight.w700;
case "extra-bold":
case "extra-bold-italic":
return FontWeight.w800;
case "black":
case "black-italic":
return FontWeight.w900;
default:
return FontWeight.normal;
}
}