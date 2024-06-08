import 'dart:async';

import 'package:MocaPass/core/local_data/session_management.dart';
import 'package:MocaPass/core/presentation/routes/routes_manager.dart';
import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:MocaPass/core/utility/strings.dart';
import 'package:MocaPass/core/utility/theme.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late MobileScannerController controller;

  @override
  void initState() {
    controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        facing:
            SessionManagement.getCamFacing(SessionManagement.cameraFacingKey) ==
                    0
                ? CameraFacing.front
                : CameraFacing.back,
        torchEnabled: false,
        useNewCameraSelector: true);
    controller.start(cameraFacingOverride:SessionManagement.getCamFacing(SessionManagement.cameraFacingKey) ==
        0
        ? CameraFacing.front
        : CameraFacing.back);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var isTablet = deviceType == DeviceScreenType.tablet ||
        deviceType == DeviceScreenType.desktop;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AiBarcodeScanner(
          canPop: false,
          bottomBar: Container(
            color: Colors.transparent,
            height: 0,
          ),
          borderRadius: 21,
          borderColor: primaryColor,
          borderWidth: 3.5.sh,
          controller: controller,
          onDetect: (capture) {},
          onScan: (capture) {
            // handleBarcodeScanning(scan, capture);
            Logger().i(capture);
            Timer(const Duration(milliseconds: 500), () {
              Navigator.of(context).pushNamed(Routes.scanSuccessScreen);
              controller.stop();
            });
          },
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 4.sw,
                  vertical: 4.sh,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    SizedBox(width: 0.5.sw),
                    Text(
                      StringConst.back,
                      style: scannerInfoTextStyle(isTablet),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.sh),
              child: Text(
                StringConst.scanInfoText,
                style: scannerInfoTextStyle(isTablet),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }
  @override
  void dispose() {

    controller.stop();
    controller.dispose();
    super.dispose();
  }
}
