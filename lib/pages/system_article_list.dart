import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/system_article.dart';
import 'package:wanandroid_flutter/pages/webview.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';

class SystemArticleListPage extends StatefulWidget {
  final int cid;
  final String title;

  SystemArticleListPage(this.cid, this.title);

  @override
  State<StatefulWidget> createState() {
    return SystemArticleListPageState();
  }
}

class SystemArticleListPageState extends State<SystemArticleListPage> {
  double screenWidth = 0;
  List<Article> articleList = new List();
  int curPage = 0;

  @override
  void initState() {
    super.initState();
    loadArticleList(curPage, widget.cid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text(widget.title),
        colors: [
          Colours.appThemeColor,
          Color(0xfffa5650),
        ],
      ),
      body: ListView.separated(
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
      ),
    );
  }

  getSystemSquareItem(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onItemClick(index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              articleList[index].title,
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
                      articleList[index].niceDate,
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
                      articleList[index].shareUser,
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

  void loadArticleList(int page, int cid) {
    HttpClient.getInstance().get(Api.SYSTEM_ARTICLE_LIST,
        data: {"page": page, "cid": cid}, callback: (data) {
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
}
