import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/models/app_theme.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<AppTheme>(context);
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("注册"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black38,
                  ),
                ),
                hintText: "请输入用户名",
                prefixIcon: Icon(
                  Icons.person,
                  color: appTheme.themeColor,
                ),
                prefixStyle: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: TextField(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: "请输入密码",
                prefixIcon: Icon(
                  Icons.lock,
                  color: appTheme.themeColor,
                ),
                prefixStyle: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: TextField(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: "再次确认密码",
                prefixIcon: Icon(
                  Icons.lock,
                  color: appTheme.themeColor,
                ),
                prefixStyle: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
