import 'package:alafein/core/presentation/routes/routes_manager.dart';
import 'package:alafein/core/utility/strings.dart';
import 'package:alafein/core/utility/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(builder: (context) {
      return MaterialApp(
        builder: EasyLoading.init(
          builder: (context, child) {
            return child!;
          },
        ),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        debugShowCheckedModeBanner: false,
        title: StringConst.appName,
        theme: themeData,
      );
    });
  }
}
