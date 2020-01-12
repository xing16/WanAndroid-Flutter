import 'package:flutter/material.dart';

class LoginState with ChangeNotifier {
  /// 是否已登录
  bool _loggedin = false;

  get loggedIn => _loggedin;

  /// 更新登录状态
  void updateLoginState(bool logged) {
    _loggedin = logged;
    notifyListeners();
  }
}
