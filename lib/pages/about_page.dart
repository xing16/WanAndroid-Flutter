import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/link_text.dart';

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
    TextStyle linkTextStyle = Theme.of(context).textTheme.body1.copyWith(
          color: Colors.blueAccent,
          fontSize: 15,
          decoration: TextDecoration.underline,
        );
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("关于"),
        colors: [
          Colours.appThemeColor,
          Color(0xfffa5650),
        ],
      ),
      body: Container(
        color: Theme.of(context).accentColor,
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "简介",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Divider(
                height: 1,
              ),
            ),
            Text(
                "玩 Android 是基于 Flutter 开发的跨平台的客户端应用，包括首页，项目，体系，搜索，妹子浏览，积分，主题切换，暗黑模式等功能。"),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Row(
                children: <Widget>[
                  Text("项目地址："),
                  LinkText(
                    "https://github.com/xing16/WanAndroid-Flutter",
                    "https://github.com/xing16/WanAndroid-Flutter",
                    linkTextStyle,
                  ),
                ],
              ),
            ),
            Container(
              child: Text(
                "依赖库",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Divider(
                height: 1,
              ),
            ),
            LinkText(
              "Dio",
              "https://github.com/flutterchina/dio",
              linkTextStyle,
            ),
            LinkText(
              "flutter_swiper",
              "https://github.com/best-flutter/flutter_swiper",
              linkTextStyle,
            ),
            LinkText(
              "webview_flutter",
              "https://github.com/apptreesoftware/flutter_webview",
              linkTextStyle,
            ),
            LinkText(
              "flutter_staggered_grid_view",
              "https://github.com/letsar/flutter_staggered_grid_view",
              linkTextStyle,
            ),
            LinkText(
              "json_annotation",
              "https://pub.dev/packages/json_annotation",
              linkTextStyle,
            ),
            LinkText(
              "fluttertoast",
              "https://pub.dev/packages/fluttertoast",
              linkTextStyle,
            ),
            LinkText(
              "provider",
              "https://pub.dev/packages/provider",
              linkTextStyle,
            ),
            LinkText(
              "shared_preferences",
              "https://pub.dev/packages/shared_preferences",
              linkTextStyle,
            ),
            LinkText(
              "flutter_easyrefresh",
              "https://github.com/xuelongqy/flutter_easyrefresh",
              linkTextStyle,
            ),
            LinkText(
              "photo_view",
              "https://github.com/renancaraujo/photo_view",
              linkTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
