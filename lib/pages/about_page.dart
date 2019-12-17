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
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              height: 100,
              color: Colors.yellow,
            ),
          ),
          Positioned(
            child: Container(
              color: Colors.deepOrange,
              width: 50,
              height: 100,
              child: Icon(Icons.add),
            ),
          ),
          Positioned(
            left: 50,
            child: Container(
              color: Colors.cyan,
              width: 50,
              height: 100,
              child: Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
