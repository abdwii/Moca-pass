import '../../../../../core/utility/colors_data.dart';
import '../../../../../core/utility/strings.dart';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:svg_flutter/svg.dart';

class PlatformCustomButton extends StatelessWidget {
  final String platform;
  final String image;
  final Function onPressed;
  const PlatformCustomButton({
    super.key,
    required this.platform,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1.5, color: Colors.black),
          borderRadius: BorderRadius.circular(12)),
      onPressed: () {
        onPressed();
      },
      color: Colors.white,
      textColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 8.sw, vertical: 4.sw),
      child: Row(
        children: [
          SvgPicture.asset(image),
          const Spacer(),
          Text(
            'Continue with $platform',
            style: TextStyle(
                fontSize: 4.sw,
                fontWeight: FontWeight.w300,
                fontFamily: StringConst.mainFont),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
