import 'package:MocaPass/features/scan/cubit/scan_cubit.dart';
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
  Logger().i(
      "\n BaseURl = ${AppConfig.baseUrl},\n authURl = ${AppConfig.authBaseUrl}, \n${AppConfig.environment}");
  await SessionManagement.init();/*
  SessionManagement.setStringValue(SessionManagement.TOKEN_KEY,
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJmYXRtYVNheWVkIiwianRpIjoiYzg2M2Q1M2MtNDU3My00ZDYxLThkZDktYTdkOTc0YWY1NmY4IiwiZW1haWwiOiJmc2F5ZWRAZG5hYXlhLmNvbSIsInVpZCI6IjQ0YjhkYjQwLTc0NjEtNDMwNy1iYzNjLTE4NTM3Njg4Y2Q0OCIsImlwIjoiMTAuMTAuMS4xOCIsInJvbGVzIjoiQWRtaW4iLCJleHAiOjE3MTgwOTQzNTcsImlzcyI6IkNvcmVJZGVudGl0eSIsImF1ZCI6IkNvcmVJZGVudGl0eVVzZXIifQ.G-Dz8E-4NtxtQploIn2bMgz_Y9v5sJ1dZiUvozkp174");
*/  Bloc.observer = MyBlocObserver();

  // initLocator();
  // runApp(DevicePreview(
  //     enabled: false,
  //     builder: (context) {
  //       return MultiBlocProvider(
  //         providers: [
  //           BlocProvider(
  //             create: (context) => LoginCubit("", ""),
  //           ),
  //         ],
  //         child: const AppWidget(),
  //       );
  //     }));
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => LoginCubit()),
      BlocProvider(create: (context) => ScanCubit()),
    ],
    child: const AppWidget(),
  ));
}
