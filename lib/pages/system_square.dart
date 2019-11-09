import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/home_article.dart';
import 'package:wanandroid_flutter/models/square_article.dart';
import 'package:wanandroid_flutter/pages/webview.dart';

class SystemSquarePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SystemSquarePageState();
  }
}

class SystemSquarePageState extends State<SystemSquarePage> {
  int page = 0;
  List<Article> articleList = new List();

  @override
  void initState() {
    super.initState();
    loadSystemSquare(page);
  }

  @override
  Widget build(BuildContext context) {
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
    return GestureDetector(
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

  void loadSystemSquare(int page) {
    HttpClient.getInstance().get(Api.SQUARE_ARTICLE + page.toString() + "/json",
        (data) {
      SquareArticle squareArticle = SquareArticle.fromJson(data);
      var articles = squareArticle?.datas;
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
