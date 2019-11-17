import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavoritePageState();
  }
}

class FavoritePageState extends State<FavoritePage> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("收藏"),
        colors: [
          Colours.appThemeColor,
          Color(0xfffa5650),
        ],
      ),
      body: Column(
        children: <Widget>[
          Image.asset("images/avatar.jpeg"),
        ],
      ),
    );
  }
}
