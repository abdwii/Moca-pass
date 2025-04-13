import 'package:MocaPass/core/presentation/routes/routes_manager.dart';
import 'package:MocaPass/core/presentation/widgets/secondary_custom_button.dart';
import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:svg_flutter/svg.dart';

import '../../../core/local_data/session_management.dart';
import '../../../core/presentation/widgets/app_background.dart';
import '../../../core/utility/assets_data.dart';
import '../../../core/utility/strings.dart';
import '../../../core/utility/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var deviceOrientation = (MediaQuery.of(context).orientation);
    var isTablet = deviceType == DeviceScreenType.tablet ||
        deviceType == DeviceScreenType.desktop;
    return AppBackground(
      child: SafeArea(
        child: Padding(
          padding: getMainHPadding(isTablet, deviceOrientation),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                SizedBox(height: isTablet ? 8.sh : 35.sw),
                SvgPicture.asset(
                  AssetsData.welcomeTo,
                  width: isTablet ? 20.sw : 35.sw,
                ),
                Gap(1.sh),
                Image.asset(
                  AssetsData.logo,
                  width: isTablet ? 35.sw : 50.sw,
                ),
                Gap(isTablet ? 10.sw : 24.sw),
                Text(StringConst.homeLabel,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white, fontSize: isTablet ? 32 : 16),textAlign: TextAlign.center,),
                Gap(2.sh),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:isTablet ? 6.sw :10.sw),
                  child: Column(
                    children: [
                      SecondaryCustomButton(
                          text: StringConst.frontCam,
                          color: kSecondaryColor,
                          iconPath: AssetsData.camera,
                          onPressed: ()async {
                           SessionManagement.setCamFacing(0);
                           navToAccess(context);
                          }),
                      Gap(2.sh),
                      SecondaryCustomButton(
                          text: StringConst.backCam,
                          color: Colors.white,
                          iconPath: AssetsData.camera,
                          onPressed: ()async {
                            SessionManagement.setCamFacing(1);
                            navToAccess(context);
                          }),
                    ],
                  ),
                ),

                Gap(isTablet ? 8.sw : 6.sw),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navToAccess(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.accessScreen);
  }
}
