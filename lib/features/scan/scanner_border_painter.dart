import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/utility/colors_data.dart';

class ScannerOverlayPainter extends CustomPainter {
  ScannerOverlayPainter(Orientation this.deviceOrientation, bool this.isTablet);

  bool isTablet;
  Orientation deviceOrientation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black38
      ..style = PaintingStyle.fill;

    final holeSize = _getSize();
    final holeOffsetX = (size.width - holeSize) / 2;
    final holeOffsetY = (size.height - holeSize) / 2;
    final radius = 3.sh;
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height)) // Full screen
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(holeOffsetX, holeOffsetY, holeSize, holeSize),
          Radius.circular(radius),
        ),
      )
      ..fillType = PathFillType.evenOdd; // Cut out effect

    canvas.drawPath(path, paint);
    final border = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(holeOffsetX, holeOffsetY, holeSize, holeSize),
          Radius.circular(radius),
        ),
      )
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(holeOffsetX, holeOffsetY, holeSize, holeSize),
          Radius.circular(radius),
        ),
      )
      ..fillType = PathFillType.evenOdd;

    final borderPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = 1.5.sh
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(border, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  double _getSize() {
    switch (deviceOrientation) {
      case Orientation.portrait:
        return isTablet ? 30.sh : 30.sh;
      case Orientation.landscape:
        return isTablet ? 30.sh : 30.sh;
    }
  }
}
