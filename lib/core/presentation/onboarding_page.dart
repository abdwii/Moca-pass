import '../../core/utility/assets_data.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 4,
        ), () {
      /*AutoRouter.of(context).replace(
        widget.route,
      );*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // SvgPicture.asset(AssetsData.onboardIcon),
            // Image.asset(AssetsData.animatedLogo),
          ],
        ),
      ),
    );
  }
}
