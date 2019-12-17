import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/models/app_theme.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/xtextfield.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  double screenWidth = 0;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  TextEditingController repwdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<AppTheme>(context);
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("注册"),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              child: XTextField(
                usernameController,
                "用户名",
                prefixIcon: Icons.person,
                suffixIcon: Icons.close,
                callback: () {
                  usernameController.text = "";
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: XTextField(
                usernameController,
                "密码",
                prefixIcon: Icons.person,
                suffixIcon: Icons.close,
                callback: () {
                  usernameController.text = "";
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: XTextField(
                usernameController,
                "确认密码",
                prefixIcon: Icons.person,
                suffixIcon: Icons.close,
                callback: () {
                  usernameController.text = "";
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 30,
              ),
              child: MaterialButton(
                elevation: 0,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                height: 46,
                minWidth: screenWidth,
                color: appTheme.themeColor,
                child: Text(
                  "注册",
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
    );
  }
}
