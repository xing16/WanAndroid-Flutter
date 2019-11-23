import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutPageState();
  }
}

class AboutPageState extends State<AboutPage> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("关于"),
        colors: [
          Colours.appThemeColor,
          Color(0xfffa5650),
        ],
      ),
      body: TextField(
        cursorColor: Colors.white,
        onChanged: (String value) {
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: "输入关键字搜索",
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.white38,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.yellow,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.yellow,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
        textInputAction: TextInputAction.search,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
