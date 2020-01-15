import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  /// 主题颜色
  Color _themeColor;

  get themeColor => _themeColor;

  /// 修改主题颜色
  void updateThemeColor(Color color) {
    this._themeColor = color;
    notifyListeners();
  }
}
