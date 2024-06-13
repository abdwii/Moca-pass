import 'dart:async';
import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:MocaPass/features/splash/cubit/refresh_token_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    Timer(
        const Duration(
          milliseconds: 20,
        ), () async {
      if (SessionManagement.getUserToken() != null &&
          SessionManagement.getUserToken()!.isNotEmpty) {
        await BlocProvider.of<RefreshTokenCubit>(context).refreshToken();
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
      }
    });
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    return Scaffold(
      body: BlocListener<RefreshTokenCubit, RefreshTokenState>(
        listener: (context, state) {
          if (state is RefreshTokenLoaded || state is RefreshTokenError) {
            Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
          }
        },
        child: Container(
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
      ),
    );
  }
}
