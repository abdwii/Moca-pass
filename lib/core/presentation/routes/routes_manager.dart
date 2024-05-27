import 'package:alafein/core/presentation/onboarding_page.dart';
import 'package:alafein/features/auth/login/presentation/login_page.dart';
import 'package:alafein/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../../../features/main/main_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainScreen = "/mainScreen";
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
