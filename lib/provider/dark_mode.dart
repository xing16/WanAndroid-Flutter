import 'package:flutter/material.dart';

class DarkMode with ChangeNotifier {
  /// 夜间模式
  bool _isDark = false;

  /// 切换白天，夜间模式
  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void setDark(isDark) {
    _isDark = isDark;
  }

  get isDark => _isDark;
}
