import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/system_article.dart';
import 'package:wanandroid_flutter/pages/webview_page.dart';
import 'package:wanandroid_flutter/widgets/article_item.dart';

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
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    // 请求数据
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
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
          return createSystemSquareItem(index);
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

  createSystemSquareItem(int index) {
    Article article = articleList[index];
    return ArticleItem(
      article.title,
      article.niceDate,
      article.author.isNotEmpty ? article.author : article.shareUser,
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

  @override
  bool get wantKeepAlive => true;

  /// 下拉刷新
  void _onRefresh() async {
    SystemArticle systemArticle = await _loadSystemSquare(0);
    setState(() {
      articleList.clear();
      articleList.addAll(systemArticle.datas);
    });
//    _refreshController.refreshCompleted();
  }

  /// 上拉加载更多
  Future<SystemArticle> _onLoadMore() async {
    SystemArticle systemArticle = await _loadSystemSquare(curPage);
    List<Article> articles = systemArticle.datas;
    setState(() {
      articleList.addAll(articles);
    });
    // 可能出现返回列表数据<每页数据，因为有自见的文章被过滤掉了。
    _refreshController.loadComplete();
  }

  Future<SystemArticle> _loadSystemSquare(int page) async {
    var result = await HttpClient.getInstance()
        .get(Api.SQUARE_ARTICLE, data: {"page": page});
    curPage = page + 1;
    SystemArticle squareArticle = SystemArticle.fromJson(result);
    return squareArticle;
  }
}
