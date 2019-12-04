import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/system_article.dart';
import 'package:wanandroid_flutter/pages/webview_page.dart';
import 'package:wanandroid_flutter/widgets/article_item.dart';

import 'favorite_page.dart';

class SystemSquarePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SystemSquarePageState();
  }
}

class SystemSquarePageState extends State<SystemSquarePage>
    with AutomaticKeepAliveClientMixin {
  int curPage = 0;
  List<Article> articleList = new List();
  GlobalKey<FavoritePageState> _easyRefreshKey =
      new GlobalKey<FavoritePageState>();

  @override
  void initState() {
    super.initState();
    loadSystemSquare(curPage);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      header: ClassicalHeader(enableHapticFeedback: false),
      key: _easyRefreshKey,
      onRefresh: () async {
        loadSystemSquare(0);
      },
      onLoad: () async {
        loadSystemSquare(curPage);
      },
      child: ListView.separated(
        itemBuilder: (context, index) {
          return getSystemSquareItem(index);
        },
        separatorBuilder: (context, index) {
          return Divider(
            indent: 12,
            endIndent: 12,
            height: 0.5,
          );
        },
        itemCount: articleList.length,
      ),
    );
  }

  getSystemSquareItem(int index) {
    Article article = articleList[index];
    return ArticleItem(
      article.title,
      article.niceDate,
      article.shareUser,
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => WebViewPage(
              url: article.link,
            ),
          ),
        );
      },
    );
  }

  void loadSystemSquare(int page) {
    HttpClient.getInstance().get(Api.SQUARE_ARTICLE, data: {"page": page},
        callback: (data) {
      curPage = page + 1;
      SystemArticle squareArticle = SystemArticle.fromJson(data);
      var articles = squareArticle.datas;
      setState(() {
        if (page == 0) {
          articleList.clear();
        }
        articleList.addAll(articles);
      });
    });
  }

  void onItemClick(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => WebViewPage(
          url: articleList[index].link,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
