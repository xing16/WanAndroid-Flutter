import 'package:flutter/material.dart';

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
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 150,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: <Widget>[
            Image(
              width: 160,
              image: AssetImage("images/android_logo.jpg"),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "请输入用户名",
              ),
            ),
            TextField(),
          ],
        ),
      ),
    );
  }
}
