import 'package:flutter/material.dart';

class ArticleItem extends StatefulWidget {
  final String title;
  final String niceDate;
  final String shareUser;
  final GestureTapCallback callback;

  ArticleItem(this.title, this.niceDate, this.shareUser, this.callback);

  @override
  State<StatefulWidget> createState() {
    return new ArticleItemState();
  }
}

class ArticleItemState extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.callback,
      child: Container(
        color: Theme.of(context).backgroundColor,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      widget.niceDate,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      widget.shareUser,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
