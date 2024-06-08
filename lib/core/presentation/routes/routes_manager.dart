import 'package:MocaPass/features/scan/scan_screen.dart';
import 'package:MocaPass/features/scan_success/scan_screen.dart';

import '../../../features/access/access_type.dart';
import '../../../features/auth/login/presentation/login_page.dart';
import '../../../features/splash/splash_page.dart';

import 'package:flutter/material.dart';

import '../../../features/home/main_screen.dart';
import '../onboarding_page.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainScreen = "/mainScreen";
  static const String accessScreen = "/accessScreen";
  static const String scanScreen = "/scanScreen";
  static const String scanSuccessScreen = "/scanSuccessScreen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.accessScreen:
        return MaterialPageRoute(builder: (_) => const AccessTypePage());
      case Routes.scanScreen:
        return MaterialPageRoute(builder: (_) => const ScanPage());
      case Routes.scanSuccessScreen:
        return MaterialPageRoute(builder: (_) => const ScanSuccessPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (BuildContext context) => Scaffold(
              appBar: AppBar(
                title: const Text("No route found."),
                elevation: 1,
              ),
              body: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close_rounded,
                      size: 25.0,
                      color: Colors.red,
                    ),
                    Text("No route found.")
                  ],
                ),
              ),
            ));
  }
}
