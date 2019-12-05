import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/models/app_theme.dart';

class SectionItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final GestureTapCallback callback;
  final EdgeInsetsGeometry margin;
  final bool showMore;
  final bool hasDivider;
  final Widget right;

  SectionItem(
    this.icon,
    this.title, {
    this.callback,
    this.margin,
    this.showMore = true,
    this.hasDivider = false,
    this.right = const Icon(
      Icons.chevron_right,
      color: Colors.black45,
      size: 30,
    ),
  });

  @override
  State<StatefulWidget> createState() {
    return new SectionItemState();
  }
}

class SectionItemState extends State<SectionItem> {
  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<AppTheme>(context);
    return GestureDetector(
      onTap: widget.callback,
      child: Container(
        color: Theme.of(context).accentColor,
        alignment: Alignment.centerLeft,
        margin: widget.margin,
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
                      visible: widget.showMore,
                      child: widget.right,
                    ),
                  ),
                  right: 5,
                ),
                Positioned(
                  child: Icon(
                    widget.icon,
                    color: appTheme.themeColor,
                    size: 22,
                  ),
                  top: 16,
                ),
                Positioned(
                  child: Text(
                    widget.title,
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
              visible: widget.hasDivider,
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
