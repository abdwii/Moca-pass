
import 'package:flutter/material.dart';

import '../../utility/colors_data.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
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
      child: child,
    );
  }
}
