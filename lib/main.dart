import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';

import '../../core/observer.dart';
import '../../core/presentation/app_widget.dart';
import '../../core/utility/assets_data.dart';
import '../../core/utility/colors_data.dart';
import '../../features/auth/login/application/cubit/login_cubit.dart';
import 'core/api/app_configs/app_config.dart';
import 'core/local_data/session_management.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.environment = Environment.development;
  Logger().i("\nBaseURl = ${AppConfig.baseUrl}, \n${AppConfig.environment}");
  await SessionManagement.init();
  configLoading();
  Bloc.observer = MyBlocObserver();

  // initLocator();
  runApp(DevicePreview(
      enabled: false,
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginCubit("", ""),
            ),
          ],
          child: const AppWidget(),
        );
      }));
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorWidget = const SizedBox(
        width: 150,
        height: 150,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ))
    ..infoWidget = SizedBox(
        width: 150, height: 150, child: Image.asset(AssetsData.blueLogo))
    ..indicatorSize = 60
    ..indicatorColor = primaryColor
    ..contentPadding = const EdgeInsets.symmetric(vertical: 12)
    ..displayDuration = const Duration(milliseconds: 1400)
    ..radius = 10.0
    ..progressColor = primaryColor
    ..backgroundColor = Colors.white
    ..textColor = Colors.black
    ..maskColor = primaryColor
    ..maskType = EasyLoadingMaskType.clear
    ..userInteractions = false
    ..animationDuration = const Duration(milliseconds: 350)
    ..dismissOnTap = false;
}
