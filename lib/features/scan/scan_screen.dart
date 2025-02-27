import 'dart:async';
import 'dart:ui';

import 'package:MocaPass/core/local_data/session_management.dart';
import 'package:MocaPass/core/presentation/routes/routes_manager.dart';
import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:MocaPass/core/utility/strings.dart';
import 'package:MocaPass/core/utility/theme.dart';
import 'package:MocaPass/features/scan/cubit/scan_cubit.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:svg_flutter/svg.dart';

import '../../core/presentation/app_bottom_sheets.dart';
import '../../core/presentation/widgets/loader_controller.dart';
import '../../core/utility/assets_data.dart';

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
/*    controller.start(
        cameraFacingOverride:
            SessionManagement.getCamFacing(SessionManagement.cameraFacingKey) ==
                    0
                ? CameraFacing.front
                : CameraFacing.back);*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var isTablet = deviceType == DeviceScreenType.tablet ||
        deviceType == DeviceScreenType.desktop;
    var deviceOrientation = (MediaQuery.of(context).orientation);

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.transparent,
      overlayWidgetBuilder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.5,
            sigmaY: 2.5,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: kSecondaryColor,
                ),
                Gap(2.sh),
                SvgPicture.asset(
                  AssetsData.m,
                  fit: BoxFit.fitWidth,
                  width: 20.sw,
                  color: kSecondaryColor,
                ),
              ],
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          BlocListener<ScanCubit, ScanState>(
            listener: (context, state) {
              if (state is ScanLoading) {
                showLoader(context);
                controller.stop();
              }
              if (state is ScanLoaded) {
                hideLoader(context);
                Timer(const Duration(milliseconds: 250), () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.scanSuccessScreen);
                });
              }
              if (state is ScanError) {
                hideLoader(context);
                controller.stop();
                showErrorDialog(state.message ?? '', context, () {
                  Navigator.of(context).pop();
                  controller.start();
                }, () {});
              }
            },
            child: AiBarcodeScanner(
              // canPop: false,
              // bottomBar: Container(
              //   color: Colors.transparent,
              //   height: 0,
              // ),
              overlayColor: kOverlayColor,
              borderRadius: 21,
              borderColor: primaryColor,
              borderWidth: 3.5.sh,
              controller: controller,
              onDetect: (capture) async{
                // handleBarcodeScanning(scan, capture);
              },
              showSuccess: false,
              // onScan: (capture) async {
              //   // handleBarcodeScanning(scan, capture);
              //   Logger().i(capture);
              //   // controller.stop();
              //   bool? isScanIn = BlocProvider.of<ScanCubit>(context).isScanIn;
              //   if (isScanIn == true) {
              //     await BlocProvider.of<ScanCubit>(context).scanIn(capture);
              //   } else if (isScanIn == false) {
              //     await BlocProvider.of<ScanCubit>(context).scanOut(capture);
              //   } else {
              //     Navigator.of(context).pop();
              //   }
              // },
            ),
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
                padding: EdgeInsets.only(
                    top: deviceOrientation == Orientation.portrait
                        ? 10.sh
                        : 2.5.sh),
                child: Text(
                  StringConst.scanInfoText,
                  style: scannerInfoTextStyle(isTablet),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }
}
