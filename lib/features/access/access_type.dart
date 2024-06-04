import 'package:MocaPass/core/local_data/session_management.dart';
import 'package:MocaPass/core/presentation/routes/routes_manager.dart';
import 'package:MocaPass/core/presentation/widgets/secondary_custom_button.dart';
import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:svg_flutter/svg.dart';
import '../../../core/presentation/widgets/app_background.dart';
import '../../../core/utility/assets_data.dart';
import '../../../core/utility/strings.dart';
import '../../../core/utility/theme.dart';
import '../../core/presentation/app_bottom_sheets.dart';

class AccessTypePage extends StatelessWidget {
  const AccessTypePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var deviceOrientation = (MediaQuery.of(context).orientation);
    var isTablet = deviceType == DeviceScreenType.tablet ||
        deviceType == DeviceScreenType.desktop;
    return AppBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      AssetsData.logout,
                      width: 3.sw,
                    ),
                    onPressed: () {
                      showAlertDialog("Log Out?",
                          "Are you sure you want to Logout?", context, () {
                        Navigator.of(context).pop();
                      }, () async {
                        SessionManagement.signOut();
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.loginRoute);
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: getMainHPadding(isTablet, deviceOrientation),
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
                    SvgPicture.asset(
                      AssetsData.scanPassTitle,
                      width: isTablet ? 25.sw : 40.sw,
                    ),
                    Gap(2.sh),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.sw),
                      child: Column(
                        children: [
                          SecondaryCustomButton(
                              text: StringConst.scanIn,
                              color: kSecondaryColor,
                              iconPath: AssetsData.scanImage,
                              onPressed: () {
                                navToScanner(context);
                              }),
                          Gap(2.sh),
                          SecondaryCustomButton(
                              text: StringConst.scanOut,
                              color: Colors.white,
                              iconPath: AssetsData.scanImage,
                              onPressed: () {
                                /*showErrorDialog(
                                    "Something Went Error!Something Went Error!Something Went Error!",
                                    context, () {
                                  Navigator.of(context).pop();
                                });*/
                                navToScanner(context);
                              }),
                        ],
                      ),
                    ),
                    Gap(isTablet ? 8.sw : 10.sh),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navToScanner(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.scanScreen);
  }
}
