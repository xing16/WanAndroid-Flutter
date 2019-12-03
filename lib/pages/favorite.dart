import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/pages/webview.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/article_item.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavoritePageState();
  }
}

class FavoritePageState extends State<FavoritePage> {
  double screenWidth = 0;
  List<Article> articleList = new List();
  List<String> list = new List();

  GlobalKey<FavoritePageState> _easyRefreshKey =
      new GlobalKey<FavoritePageState>();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 30; i++) {
      list.add("cdcd");
    }
  }

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
      body: EasyRefresh(
        header: ClassicalHeader(enableHapticFeedback: false),
        key: _easyRefreshKey,
        onRefresh: () async {},
        onLoad: () async {},
        child: ListView.separated(
          itemBuilder: (context, index) {
            return getFavoriteListItem(index);
          },
          separatorBuilder: (context, index) {
            return Divider(
              indent: 12,
              endIndent: 12,
              height: 0.5,
            );
          },
          itemCount: list.length,
        ),
      ),
    );
  }

  getFavoriteListItem(int index) {
//    Article article = articleList[index];
//    return ArticleItem(
//      article.title,
//      article.niceDate,
//      article.shareUser,
//      () {
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (BuildContext context) => WebViewPage(
//              url: article.link,
//            ),
//          ),
//        );
//      },
//    );
    return Container(
      height: 50,
      child: Text("ccdscasdc"),
    );
  }
}
