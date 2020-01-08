import 'dart:ui';

import 'package:flutter/material.dart';

double getStatusBarHeight() {
  return MediaQueryData.fromWindow(window).padding.top;
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
