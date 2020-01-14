import 'package:wanandroid_flutter/models/user_info.dart';

class UserInfoManager {
  UserInfo userInfo;

  // 工厂模式
  factory UserInfoManager() => getInstance();

  static UserInfoManager _instance;

  UserInfoManager._internal() {
    // 初始化
    userInfo = UserInfo.fromMap({});
  }

  static UserInfoManager getInstance() {
    if (_instance == null) {
      _instance = new UserInfoManager._internal();
    }
    return _instance;
  }

  void setUserInfo(UserInfo userInfo) {
    this.userInfo = userInfo;
  }

  UserInfo getUserInfo() {
    return userInfo;
  }
}
