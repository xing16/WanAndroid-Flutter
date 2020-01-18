import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/system_article.dart';
import 'package:wanandroid_flutter/pages/webview_page.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/article_item.dart';
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
  int cid = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    cid = widget.cid;
    _onRefresh();
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
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("上拉加载");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败！点击重试！");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("上拉加载更多");
            } else {
              body = Text("没有更多数据了!");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoadMore,
        child: ListView.separated(
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
      ),
    );
  }

  getSystemSquareItem(int index) {
    Article article = articleList[index];
    return ArticleItem(
      article.title,
      article.author.isNotEmpty ? article.author : article.shareUser,
      article.niceDate,
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

  /// 请求数据
  Future<SystemArticle> _loadArticleList(int page, int cid) async {
    var result = await HttpClient.getInstance()
        .get(Api.SYSTEM_ARTICLE_LIST, data: {"page": page, "cid": cid});
    curPage = page + 1;
    SystemArticle squareArticle = SystemArticle.fromJson(result);
    return squareArticle;
  }

  /// 下拉刷新
  void _onRefresh() async {
    SystemArticle systemArticle = await _loadArticleList(0, cid);
    setState(() {
      articleList.clear();
      articleList.addAll(systemArticle.datas);
    });
    _refreshController.refreshCompleted();
  }

  /// 上拉加载更多
  Future<SystemArticle> _onLoadMore() async {
    SystemArticle systemArticle = await _loadArticleList(curPage, cid);
    List<Article> articles = systemArticle.datas;
    if (articles.length < systemArticle.size) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
    setState(() {
      articleList.addAll(articles);
    });
  }
}
