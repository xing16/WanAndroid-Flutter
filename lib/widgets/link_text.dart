import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/pages/webview_page.dart';

class LinkText extends StatefulWidget {
  final String content;
  final String url;
  final TextStyle contentTextStyle;

  LinkText(this.content, this.url, this.contentTextStyle);

  @override
  State<StatefulWidget> createState() {
    return LinkTextState();
  }
}

class LinkTextState extends State<LinkText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: widget.content,
              style: widget.contentTextStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => WebViewPage(
                        url: widget.url,
                      ),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
