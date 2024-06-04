import 'package:MocaPass/core/local_data/session_management.dart';
import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:MocaPass/core/utility/strings.dart';
import 'package:MocaPass/core/utility/theme.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AiBarcodeScanner(
          bottomBar: Container(
            color: Colors.transparent,
            height: 0,
          ),
          borderRadius: 21,
          borderColor: primaryColor,
          borderWidth: 3.5.sh,
          controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
              facing: SessionManagement.getCamFacing(
                          SessionManagement.cameraFacingKey) == 0
                  ? CameraFacing.front
                  : CameraFacing.back,
              torchEnabled: false,
              useNewCameraSelector: false),
          onDetect: (capture) {},
          onScan: (capture) {
            // handleBarcodeScanning(scan, capture);
            Logger().i(capture);
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
                      style: scannerInfoTextStyle(),
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
                style: scannerInfoTextStyle(),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }
}
