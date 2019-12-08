import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/models/app_theme.dart';
import 'package:wanandroid_flutter/pages/register_page.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/beizier_path_painter.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<AppTheme>(context);
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
              child: TextField(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: Colors.black38,
                    ),
                  ),
                  hintText: "用户名",
                  prefixIcon: Icon(
                    Icons.person,
                    color: appTheme.themeColor,
                  ),
                  prefixStyle: TextStyle(
                    color: Colors.black87,
                  ),
                  suffixIcon: Icon(
                    Icons.close,
                    size: 22,
                    color: Colors.black87,
                  ),
                ),
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
              child: TextField(
                obscureText: true,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                    hintText: "密码",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: appTheme.themeColor,
                    ),
                    prefixStyle: TextStyle(
                      color: Colors.black87,
                    ),
                    suffixIcon: Container(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              right: 12,
                            ),
                            child: Icon(
                              Icons.visibility,
                              size: 22,
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.close,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    )),
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
                      onPressed: () {},
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
                          fontSize: 16,
                          color: Colors.white,
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
                    color: Colors.black87,
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
}
