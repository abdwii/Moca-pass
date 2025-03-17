import 'dart:async';
import 'dart:ui';

import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:MocaPass/features/scan/CameraApp.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:svg_flutter/svg.dart';

import '../../core/local_data/session_management.dart';
import '../../core/presentation/app_bottom_sheets.dart';
import '../../core/presentation/routes/routes_manager.dart';
import '../../core/presentation/widgets/loader_controller.dart';
import '../../core/utility/assets_data.dart';
import 'cubit/scan_cubit.dart';

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
          SessionManagement.getCamFacing(SessionManagement.cameraFacingKey) == 0
              ? CameraFacing.front
              : CameraFacing.back,
      torchEnabled: false,
      useNewCameraSelector: false,
    );
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
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
        alignment: Alignment.center,
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
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(Routes.scanSuccessScreen);
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
              hideGalleryButton: true,
              hideSheetDragHandler: true,
              hideSheetTitle: true,
              overlayColor: kOverlayColor,
              borderRadius: 21,
              borderColor: primaryColor,
              borderWidth: 3.sh,
              controller: controller,
              onDetect: (capture) async {
                Logger().i(capture);
                bool? isScanIn = BlocProvider.of<ScanCubit>(context).isScanIn;
                if (isScanIn == true &&
                    capture.barcodes.isNotEmpty &&
                    capture.barcodes[0].rawValue != null) {
                  await BlocProvider.of<ScanCubit>(
                    context,
                  ).scanIn(capture.barcodes[0].rawValue!);
                } else if (isScanIn == false &&
                    capture.barcodes.isNotEmpty &&
                    capture.barcodes[0].rawValue != null) {
                  await BlocProvider.of<ScanCubit>(
                    context,
                  ).scanOut(capture.barcodes[0].rawValue!);
                } else {
                  Navigator.of(context).pop();
                }
              },
              showSuccess: false,
            ),
          ),
          // CameraApp(),
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
