import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/pages/webview_page.dart';
import 'package:wanandroid_flutter/widgets/article_item.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/models/article_response.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  int currentPage = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final SlidableController slidableController = SlidableController();

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("收藏"),
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
            return createFavoriteListItem(context, index);
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

  createFavoriteListItem(BuildContext context, int index) {
    Article article = articleList[index];
    String author;
    if (article.author != null) {
      author = article.author;
    } else if (article.shareUser != null) {
      author = article.shareUser;
    } else {
      author = "";
    }
    return Slidable(
      // slidableController 控制只有一个 slidable 处于打开状态
      controller: slidableController,
      actionPane: SlidableStrechActionPane(),
      actionExtentRatio: 0.25,
      child: ArticleItem(
        article.title,
        article.niceDate,
        author,
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
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          iconWidget: Image.asset(
            "images/favorite_cancel.png",
            width: 30,
            height: 30,
          ),
          caption: 'cancel favorite',
          color: Colors.red,
//          icon: Icons.delete,
          onTap: () => _cancelFavorite(index),
        ),
      ],
    );
  }

  /// 请求数据
  _loadFavorites(int page) async {
    var result = await HttpClient.getInstance()
        .get(Api.FAVORITE_LIST, data: {"page": page});
    return result;
  }

  /// 取消收藏
  _cancelFavorite(int index) async {
    Article article = articleList[index];
    await HttpClient.getInstance().post(
        Api.UNCOLLECT_LIST + "${article.id}/json",
        data: {"originId": "-1"});
    setState(() {
      articleList.removeAt(index);
    });
  }

  /// 下拉刷新
  void _onRefresh() async {
    var result = await _loadFavorites(0);
    currentPage = 0;
    if (result != null) {
      ArticleResponse articleResponse = ArticleResponse.fromJson(result);
      List<Article> articles = articleResponse.datas;
      setState(() {
        articleList.clear();
        articleList.addAll(articles);
      });
    }
    // 下拉刷新完成重置footer状态，否则此后无法上拉加载更多
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  /// 上拉加载更多
  void _onLoadMore() async {
    var result = await _loadFavorites(currentPage);
    currentPage++;
    if (result != null) {
      ArticleResponse articleResponse = ArticleResponse.fromJson(result);
      List<Article> articles = articleResponse.datas;
      if (articles.length < articleResponse.size) {
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
      setState(() {
        articleList.addAll(articles);
      });
    }
  }
}
