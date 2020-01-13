import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/manager/UserInfoManager.dart';
import 'package:wanandroid_flutter/models/user_info.dart';
import 'package:wanandroid_flutter/pages/register_page.dart';
import 'package:wanandroid_flutter/provider/app_theme.dart';
import 'package:wanandroid_flutter/widgets/beizier_path_painter.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/xtextfield.dart';
import "package:wanandroid_flutter/res/strings.dart";
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/login_state.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  double screenWidth = 0;
  bool isHidden = true;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCacheUsername().then((value) {
      usernameController.text = value;
    });
    loadCachePassword().then((value) {
      pwdController.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("casdcasdc--------");
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
//      backgroundColor: Theme.of(context).accentColor,
      appBar: GradientAppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.close,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Consumer<AppTheme>(
              builder: (BuildContext context, AppTheme appTheme, child) {
                return CustomPaint(
                  size: Size(screenWidth, 150),
                  painter: BezierPathPainter(appTheme.themeColor),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
//            child: Text("ccc"),
            child: XTextField(
              usernameController,
              "用户名",
              prefixIcon: Icons.person,
              obscureText: false,
              suffixIcon: Icon(
                Icons.close,
//                color: Theme.of(context).textTheme.button.color,
              ),
              onChanged: (text) {},
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: XTextField(
              pwdController,
              "密  码",
              prefixIcon: Icons.lock,
              suffixIcon: Icon(
                Icons.close,
                color: Theme.of(context).textTheme.button.color,
              ),
              onChanged: (text) {},
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 30,
            ),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Consumer<AppTheme>(
                    builder: (BuildContext context, AppTheme appTheme, child) {
                      return MaterialButton(
                        elevation: 0,
                        onPressed: () {
                          login();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        height: 46,
                        color: appTheme.themeColor,
                        child: Text(
                          "登录",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10,
            ),
            margin: EdgeInsets.only(
              left: 20,
            ),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return RegisterPage();
                    },
                  ),
                );
              },
              child: Text(
                "注册账号?",
                style: TextStyle(
                  color: Theme.of(context).textTheme.body1.color,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login() async {
    String username = usernameController.text;
    String password = pwdController.text;
    if (username.isEmpty) {
      Fluttertoast.showToast(msg: "请输入用户名");
      return;
    }
    if (password.isEmpty) {
      Fluttertoast.showToast(msg: "请输入密码");
      return;
    }
    // 缓存用户名，密码至本地
    saveUsernamePassword(username, password);
    var result = await HttpClient.getInstance().post(Api.USER_LOGIN,
        data: {"username": username, "password": password});
    Provider.of<LoginState>(context).updateLoginState(true);
    UserInfo userInfo = UserInfo.fromJson(result);
    print("userinfo = $userInfo");
    if (userInfo != null) {
      Navigator.pop(context);
      UserInfoManager.getInstance().setUserInfo(userInfo);
    }
  }

  /// 缓存用户名，密码至本地
  void saveUsernamePassword(String username, String password) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(Strings.USERNAME, username);
    sp.setString(Strings.PASSWORD, password);
  }

  /// 加载缓存中的用户名
  loadCacheUsername() async {
    var sp = await SharedPreferences.getInstance();
    return sp.getString(Strings.USERNAME);
  }

  /// 加载缓存中的密码
  loadCachePassword() async {
    var sp = await SharedPreferences.getInstance();
    return sp.getString(Strings.PASSWORD);
  }
}
