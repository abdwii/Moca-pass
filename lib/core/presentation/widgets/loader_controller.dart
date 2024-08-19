import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

// class LoaderController {
//   BuildContext context;
//
// }

void showLoader(BuildContext context) {
  context.loaderOverlay.show();
}

void hideLoader(BuildContext context) {
  context.loaderOverlay.hide();
}