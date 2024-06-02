import '../../core/presentation/routes/routes_manager.dart';
import '../../core/utility/strings.dart';
import '../../core/utility/theme.dart';
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
        initialRoute: Routes.mainScreen,
        debugShowCheckedModeBanner: false,
        title: StringConst.appName,
        theme: themeData,
      );
    });
  }
}
