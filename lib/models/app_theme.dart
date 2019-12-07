import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  /// 夜间模式
  bool _isDark = false;

  /// 主题颜色
  Color _themeColor = Colors.redAccent;

  get themeColor => _themeColor;

  get isDark => _isDark;

  /// 切换白天，夜间模式
  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void setDark(isDark) {
    _isDark = isDark;
  }

  /// 修改主题颜色
  void updateThemeColor(Color color) {
    this._themeColor = color;
    notifyListeners();
  }
}
