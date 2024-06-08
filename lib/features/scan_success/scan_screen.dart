import 'dart:async';

import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:MocaPass/core/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:svg_flutter/svg.dart';

import '../../core/presentation/routes/routes_manager.dart';
import '../../core/presentation/widgets/app_background.dart';
import '../../core/utility/assets_data.dart';
import '../../core/utility/theme.dart';

class ScanSuccessPage extends StatelessWidget {
  const ScanSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var deviceOrientation = (MediaQuery.of(context).orientation);
    var isTablet = deviceType == DeviceScreenType.tablet ||
        deviceType == DeviceScreenType.desktop;
    Timer(const Duration(seconds: 5), (){
      Navigator.of(context).popUntil(ModalRoute.withName(Routes.scanScreen));
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: getLoginHPadding(isTablet, deviceOrientation),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Gap(12.sh),
                SvgPicture.asset(
                  AssetsData.welcomeTo,
                  width: isTablet ? 20.sw : 35.sw,
                ),
                Gap(1.sh),
                Image.asset(
                  AssetsData.logo,
                  width: isTablet ? 35.sw : 50.sw,
                ),
                Image.asset(
                  AssetsData.scanAnime,
                ),
                 Text(
                  "Scan Successful\nEnjoy your Day!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: StringConst.mainFont,
                      fontWeight: FontWeight.w500,
                      fontSize: isTablet?48:28,
                      color: kSecondaryColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
