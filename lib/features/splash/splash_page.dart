import 'dart:async';

import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/presentation/routes/routes_manager.dart';
import '../../core/utility/assets_data.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
    });
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.49, 0.87),
              end: Alignment(-0.49, -0.87),
              colors: [
                primaryColor,
                Color(0xFFFD00E2),
              ],
            ),
          ),
          child: deviceType == DeviceScreenType.tablet ||
                  deviceType == DeviceScreenType.desktop
              ? Image.asset(
                  AssetsData.splash,
                  fit: BoxFit.fitWidth,
                  height: double.infinity,
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 35.sw),
                  child: Image.asset(
                    AssetsData.splash,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                )),
    );
  }
}
