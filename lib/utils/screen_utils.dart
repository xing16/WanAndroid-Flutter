import 'dart:ui';

import 'package:flutter/material.dart';

class ScreenUtils {
  static double getStatusBarHeight() {
    return MediaQueryData.fromWindow(window).padding.top;
  }
}
