import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/manager/UserInfoManager.dart';
import 'package:wanandroid_flutter/models/user_info.dart';
import 'package:wanandroid_flutter/pages/register_page.dart';
import 'package:wanandroid_flutter/provider/app_theme_provider.dart';
import 'package:wanandroid_flutter/widgets/beizier_path_painter.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/xtextfield.dart';

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
  Widget build(BuildContext context) {
    var appTheme = Provider.of<AppThemeProvider>(context);
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: CustomPaint(
                size: Size(screenWidth, 150),
                painter: BezierPathPainter(appTheme.themeColor),
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
                usernameController,
                "用户名",
                prefixIcon: Icons.person,
                obscureText: false,
                suffixIcon: Icon(
                  Icons.close,
                  color: Theme.of(context).textTheme.button.color,
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
                    child: MaterialButton(
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
    var result = await HttpClient.getInstance().post(Api.USER_LOGIN,
        data: {"username": username, "password": password});
    UserInfo userInfo = UserInfo.fromJson(result);
    print("userinfo = $userInfo");
    if (userInfo != null) {
      Navigator.pop(context);
      UserInfoManager.getInstance().setUserInfo(userInfo);
    }
  }
}
