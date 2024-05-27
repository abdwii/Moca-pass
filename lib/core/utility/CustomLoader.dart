 import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomLoader extends EasyLoadingAnimation {
  CustomLoader();

 @override
 Widget buildWidget(
     Widget child,
     AnimationController controller,
     AlignmentGeometry alignment,
     ) {
   return Opacity(
     opacity: controller.value,
     child: RotationTransition(
       turns: controller,
       child: child,
     ),
   );
 }
 }