import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/system_article.dart';
import 'package:wanandroid_flutter/pages/webview.dart';
import 'package:wanandroid_flutter/widgets/article_item.dart';

class SystemSquarePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SystemSquarePageState();
  }
}

class SystemSquarePageState extends State<SystemSquarePage>
    with AutomaticKeepAliveClientMixin {
  int page = 0;
  List<Article> articleList = new List();

  @override
  void initState() {
    super.initState();
    loadSystemSquare(page);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      itemBuilder: (context, index) {
        return getSystemSquareItem(index);
      },
      separatorBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          color: Colors.black12,
          height: 0.5,
        );
      },
      itemCount: articleList.length,
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
      SystemArticle squareArticle = SystemArticle.fromJson(data);
      var articles = squareArticle.datas;
      setState(() {
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
