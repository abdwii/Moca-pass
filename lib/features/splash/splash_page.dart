import 'dart:async';

import 'package:alafein/core/debugging/log.dart';
import 'package:alafein/core/local_data/session_management.dart';
import 'package:alafein/core/presentation/routes/routes_manager.dart';
import 'package:alafein/core/utility/assets_data.dart';
import 'package:alafein/core/utility/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

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

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Stack(alignment: Alignment.center, children: [
          SvgPicture.asset(AssetsData.logo),
        ]),
      ),
    );
  }
}
