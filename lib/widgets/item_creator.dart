import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/res/colors.dart';

class ItemCreator {
  static createItem(BuildContext context, IconData icon, String text,
      GestureTapCallback callback,
      {EdgeInsetsGeometry margin,
      Widget right = const Icon(
        Icons.chevron_right,
        color: Colors.black45,
        size: 30,
      ),
      bool hasDivider = false,
      bool showMore = true}) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        color: Theme.of(context).accentColor,
        alignment: Alignment.centerLeft,
        margin: margin,
        padding: EdgeInsets.only(
          left: 15,
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 52,
                ),
                Positioned(
                  height: 52,
                  child: Container(
                    alignment: Alignment.center,
                    child: Visibility(
                      visible: showMore,
                      child: right,
                    ),
                  ),
                  right: 5,
                ),
                Positioned(
                  child: Icon(
                    icon,
                    color: Colours.appThemeColor,
                    size: 22,
                  ),
                  top: 16,
                ),
                Positioned(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  left: 36,
                  top: 14,
                ),
              ],
            ),
            Visibility(
              visible: hasDivider,
              child: Divider(
                indent: 30,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
