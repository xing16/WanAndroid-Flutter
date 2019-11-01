import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/res/colors.dart';

/// 渐变色 AppBar
class GradientAppBar {
  create(BuildContext context, String title) {
    return PreferredSize(
      child: Container(
        child: AppBar(
          title: Text(title),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colours.appThemeColor,
              Color(0xfffa5650),
            ],
          ),
        ),
      ),
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        45,
      ),
    );
  }
}
