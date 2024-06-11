import 'package:MocaPass/core/presentation/widgets/main_custom_button.dart';
import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utility/strings.dart';

void showErrorDialog(
    String message, BuildContext context, VoidCallback onPress) {
  showModalBottomSheet(
    isDismissible: true,
    backgroundColor: kSecondaryColor,
    context: context,
    enableDrag: true,
    constraints: const BoxConstraints(minWidth: double.infinity),
    builder: (BuildContext context) {
      return BottomSheet(
        constraints: const BoxConstraints(minWidth: double.infinity),
        backgroundColor: kSecondaryColor,
        enableDrag: true,
        dragHandleSize: const Size(100, 4),
        showDragHandle: true,
        dragHandleColor: primaryColor,
        builder: (context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 0.3.sh,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                        fontFamily: StringConst.mainFont,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.sh,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: MainCustomButton(
                      buttonName: StringConst.tryAgain,
                      isEnabled: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.sw,
                        vertical: 2.sw,
                      ),
                      backgroundColor: primaryColor,
                      onPressed: onPress),
                ),
                SizedBox(
                  height: 2.sh,
                ),
              ],
            ),
          );
        },
        onClosing: () {},
      );
    },
  );
}

void showAlertDialog(String title, String message, BuildContext context,
    VoidCallback cancel, VoidCallback yes) {
  showModalBottomSheet(
    isDismissible: false,
    backgroundColor: kErrorColor,
    context: context,
    enableDrag: false,
    constraints: const BoxConstraints(minWidth: double.infinity),
    builder: (BuildContext context) {
      // var deviceType = getDeviceType(MediaQuery.of(context).size);
      // var isTablet = deviceType == DeviceScreenType.tablet ||
      //     deviceType == DeviceScreenType.desktop;
      return BottomSheet(
        constraints: const BoxConstraints(minWidth: double.infinity),
        backgroundColor: kErrorColor,
        enableDrag: false,
        dragHandleSize: const Size(100, 4),
        showDragHandle: true,
        dragHandleColor: Colors.white,
        builder: (context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 0.3.sh,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryColor,
                        fontFamily: StringConst.mainFont,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.3.sh,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: StringConst.mainFont,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.sh,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: MainCustomButton(
                          buttonName: StringConst.cancel,
                          isEnabled: true,
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.sw,
                            vertical: 1.5.sw,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: cancel),
                    ),
                    SizedBox(width: 4.sw),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: MainCustomButton(
                          buttonName: StringConst.yes,
                          isEnabled: true,
                          padding: EdgeInsets.symmetric(
                            horizontal: 9.sw,
                            vertical: 1.5.sw,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: yes),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.sh,
                ),
              ],
            ),
          );
        },
        onClosing: () {},
      );
    },
  );
}
