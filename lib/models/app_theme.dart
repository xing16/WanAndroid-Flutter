import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  bool _isDark = false;

  get isDark => _isDark;

  set setIsDark(dark) {
    this._isDark = dark;
    notifyListeners();
  }

  switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
