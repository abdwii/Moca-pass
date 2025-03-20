import 'dart:async';
import 'dart:ui';

import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:MocaPass/features/scan/qr_code_scanner_basic.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.transparent,
      overlayWidgetBuilder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
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
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          BlocListener<ScanCubit, ScanState>(
            listener: (context, state) {
              if (state is ScanLoading) {
                showLoader(context);
                // controller.stop();
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
                // controller.stop();
                showErrorDialog(state.message ?? '', context, () {
                  Navigator.of(context).pop();
                  // controller.start();
                }, () {});
              }
            },
            child: QRCodeScannerBasic(
              isBackCamera: SessionManagement.getCamFacing(),
              onScanned: (data) async {
                Logger().i(data);
                bool? isScanIn = BlocProvider.of<ScanCubit>(context).isScanIn;
                if (isScanIn == true && data.isNotEmpty) {
                  await BlocProvider.of<ScanCubit>(
                    context,
                  ).scanIn(data);
                } else if (isScanIn == false && data.isNotEmpty) {
                  await BlocProvider.of<ScanCubit>(
                    context,
                  ).scanOut(data);
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          // CameraApp(),
        ],
      ),
    );
  }
}
