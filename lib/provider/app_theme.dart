import 'package:flutter/material.dart';

import '../models/theme_color.dart';

class AppTheme with ChangeNotifier {
  /// 主题颜色
  ThemeColor _themeColor;

  get themeColor => _themeColor;

  /// 修改主题颜色
  void updateThemeColor(ThemeColor themeColor) {
    this._themeColor = themeColor;
    notifyListeners();
  }
}
