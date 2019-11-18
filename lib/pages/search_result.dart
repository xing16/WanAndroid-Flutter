import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';

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
        return Container();
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

  void loadSearchResult(keyword, int curPage) {
    HttpClient.getInstance().get(Api.ARTICLE_SEARCH, callback: (data) {});
  }
}
