import 'package:flutter/material.dart';

/// 渐变色 AppBar
class GradientAppBar {
  static create(BuildContext context, Color startColor, Color endColor,
      {String title, bool centerTitle = false, List<Widget> actions}) {
    return PreferredSize(
      child: Container(
        child: AppBar(
          titleSpacing: 0,
          title: Text(title),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: centerTitle,
          actions: actions,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              startColor,
              endColor,
            ],
          ),
        ),
      ),
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        55,
      ),
    );
  }
}
