import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/pages/register.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: GradientAppBar(
//        leading: IconButton(
//          icon: Icon(
//            Icons.close,
//            color: Colors.black87,
//            size: 30,
//          ),
//          onPressed: () {
//            Navigator.pop(context);
//          },
//        ),
//        colors: [
//          Colors.transparent,
//          Colors.transparent,
//        ],
//        brightness: Brightness.light,
//      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 100,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: <Widget>[
              Image(
                width: 160,
                color: Theme.of(context).backgroundColor,
                image: AssetImage("images/android_logo.jpg"),
              ),
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
                    ),
                    prefixStyle: TextStyle(
                      color: Colors.black87,
                    ),
                    suffixIcon: Icon(
                      Icons.close,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
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
                    hintText: "请输入密码",
                    prefixIcon: Icon(Icons.lock),
                    prefixStyle: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30,
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
                        color: Colours.appThemeColor,
                        child: Text(
                          "登录",
                          style: TextStyle(
                            fontSize: 16,
//                            color: Colors.white,
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
//                child: MaterialButton(
//                  color: Theme.of(context).backgroundColor,
//                  onPressed: () {},
//                  child: Text(
//                    "注册账号?",
//                    style: TextStyle(
//                      color: Colors.black87,
//                      decoration: TextDecoration.underline,
//                      fontSize: 16,
//                    ),
//                  ),
//                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
