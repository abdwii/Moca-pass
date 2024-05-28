import 'dart:async';
import 'package:responsive_builder/responsive_builder.dart';
import '../../core/debugging/log.dart';
import '../../core/local_data/session_management.dart';
import '../../core/presentation/routes/routes_manager.dart';
import '../../core/utility/assets_data.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
      if (SessionManagement.getUserToken() != null &&
          SessionManagement.getUserToken()!.isNotEmpty) {
        Log.info("Token : ${SessionManagement.getUserToken()}");
        /*AutoRouter.of(context).replace(
          OnboardingRoute(route: MainRoute()),
        );*/
      } else {
        /*AutoRouter.of(context).replace(
          OnboardingRoute(route: const LoginRoute()),
        );*/
      }
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
              Color(0xFF9A28CD),
              Color(0xFFFD00E2),
            ],
          ),
        ),
        child:deviceType==DeviceScreenType.tablet? Image.asset(
          AssetsData.splash,
          fit: BoxFit.fitWidth,
          height: double.infinity,
        ):Padding(
          padding:  EdgeInsets.symmetric(vertical: 35.sw),
          child: Image.asset(
            AssetsData.splash,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
        )
      ),
    );
  }
}
