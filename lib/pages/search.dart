import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/item_creator.dart';
import 'package:wanandroid_flutter/widgets/painter.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar.create(
        context,
        Colours.appThemeColor,
        Color(0xfffa5650),
        title: "搜索",
      ),
      body: Container(
        color: Colors.amber,
        child: CustomPaint(
          size: Size(220, 220),
          painter: MyPointer(),
        ),
      ),
    );
  }
}
