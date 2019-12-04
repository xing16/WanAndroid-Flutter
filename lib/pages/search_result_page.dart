import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/pages/webview_page.dart';
import 'package:wanandroid_flutter/widgets/article_item.dart';

class SearchResultPage extends StatefulWidget {
  final String keyword;

  SearchResultPage(this.keyword, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new SearchResultPageState();
  }
}

class SearchResultPageState extends State<SearchResultPage> {
  int curPage = 0;
  List<Article> articleList = new List();

  @override
  void initState() {
    super.initState();
    loadSearchResult(widget.keyword, curPage);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var article = articleList[index];
        return ArticleItem(article.title, article.niceDate, article.shareUser,
            () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => WebViewPage(
                url: article.link,
              ),
            ),
          );
        });
      },
      separatorBuilder: (context, index) {
        return Divider(
          indent: 12,
          endIndent: 12,
          height: 0.5,
        );
      },
      itemCount: articleList.length,
    );
  }

  void loadSearchResult(keyword, int page) {
    HttpClient.getInstance().post(Api.ARTICLE_SEARCH,
        data: {"page": page.toString(), "k": keyword}, callback: (data) {
      print("data ===== bnner === $data");
      if (data is List) {
        setState(() {
          articleList = data.map((map) => Article.fromJson(map)).toList();
        });
      }
    });
  }
}
