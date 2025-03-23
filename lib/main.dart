import 'package:MocaPass/features/scan/cubit/scan_cubit.dart';
import 'package:MocaPass/features/splash/cubit/refresh_token_cubit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../core/observer.dart';
import '../../core/presentation/app_widget.dart';
import '../../features/auth/login/application/cubit/login_cubit.dart';
import 'core/api/app_configs/app_config.dart';
import 'core/local_data/session_management.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.environment = Environment.development;
  if(AppConfig.environment != Environment.production) {
    {
      Logger().i(
          "\n BaseURl = ${AppConfig.baseUrl},\n authURl = ${AppConfig.authBaseUrl}, \n${AppConfig.environment}");
    }
  }
  await SessionManagement.init();
  Bloc.observer = MyBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => RefreshTokenCubit()),
      BlocProvider(create: (context) => LoginCubit()),
      BlocProvider(create: (context) => ScanCubit()),
    ],
    child: const AppWidget(),
  ));
}