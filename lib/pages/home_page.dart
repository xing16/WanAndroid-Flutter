import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/home_article.dart';
import 'package:wanandroid_flutter/models/home_banner.dart';
import 'package:wanandroid_flutter/pages/search_page.dart';
import 'package:wanandroid_flutter/pages/webview_page.dart';
import 'package:wanandroid_flutter/provider/app_theme.dart';
import 'package:wanandroid_flutter/utils/screen_utils.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Article> articleLIst = new List();
  List<HomeBanner> banners = new List();
  ScrollController mController = new ScrollController();
  double appBarOpacity = 0;
  int curPage = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    mController.addListener(() {
      double opacity = mController.offset / 150;
      if (opacity < 0.0) {
        opacity = 0.0;
      } else if (opacity > 1.0) {
        opacity = 1.0;
      }
      setState(() {
        appBarOpacity = opacity;
      });
    });
    _loadRefresh();
  }

  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<AppTheme>(context);

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: SmartRefresher(
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
                onRefresh: _loadRefresh,
                onLoading: _loadMore,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (index < 1) {
                      return createHomeHeader(appTheme.themeColor);
                    }
                    int itemIndex = index - 1;
                    return createHomePageItem(context, itemIndex);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: 12,
                      endIndent: 12,
                      height: 0.5,
                    );
                  },
                  controller: mController,
                  itemCount: articleLIst.length + 1,
                ),
              ),
            ),
            Opacity(
              opacity: appBarOpacity,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                height: getStatusBarHeight() + 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      appTheme.themeColor,
                      appTheme.themeColor,
                    ],
                  ),
                ),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    Container(),
                    Positioned(
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return SearchPage("");
                            }),
                          );
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Center(
                      child: const Text(
                        "玩 Android",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 首页普通 item
  createHomePageItem(BuildContext context, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // item 点击事件
      onTap: () {
        onArticleItemClick(context, index); //处理点击事件
      },
      child: Container(
        padding: EdgeInsets.all(12),
        color: Theme.of(context).backgroundColor,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              articleLIst[index].title,
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
                  Visibility(
                    visible: articleLIst[index].fresh,
                    child: Container(
                      child: Text(
                        "最新",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      margin: EdgeInsets.only(
                        right: 20,
                      ),
                      padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                        border: Border.all(
                          color: Colors.red,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      articleLIst[index].author.isNotEmpty
                          ? articleLIst[index].author
                          : articleLIst[index].shareUser,
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                  Container(
                    child: Text(
                      articleLIst[index].niceDate,
                      style: Theme.of(context).textTheme.body2,
                    ),
                    margin: EdgeInsets.only(
                      left: 20,
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

  /// 首页 header
  createHomeHeader(Color themeColor) {
    return Container(
      height: 200,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            banners[index].imagePath,
            fit: BoxFit.cover,
          );
        },
        itemCount: banners.length,
        pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            size: 8,
            activeSize: 8,
            activeColor: themeColor,
          ),
        ),
        autoplay: true,
        onTap: (int index) {
          onBannerItemClick(banners[index].url);
        },
      ),
    );
  }

  /// 请求首页文章列表
  Future<HomeArticle> loadHomeArticles(int page) async {
    var result = await HttpClient.getInstance()
        .get(Api.HOME_ARTICLE, data: {"page": page});
    curPage = page + 1;
    return HomeArticle.fromJson(result);
  }

  /// 请求首页 banner
  Future<List<dynamic>> _loadBanner() async {
    return await HttpClient.getInstance().get(Api.BANNER);
  }

  /// item 点击事件
  void onArticleItemClick(BuildContext context, int position) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => WebViewPage(
          url: articleLIst[position].link,
        ),
      ),
    );
  }

  void onBannerItemClick(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => WebViewPage(
          url: url,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  /// 加载刷新
  void _loadRefresh() async {
    List<dynamic> homeBanners = await _loadBanner();
    HomeArticle homeArticle = await loadHomeArticles(0);
    setState(() {
      banners = homeBanners.map((map) => HomeBanner.fromJson(map)).toList();
      articleLIst.clear();
      articleLIst.addAll(homeArticle.datas);
    });
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  /// 加载更多
  void _loadMore() async {
    var homeArticle = await loadHomeArticles(curPage);
    setState(() {
      articleLIst.addAll(homeArticle.datas);
    });
    if (homeArticle.datas.length < homeArticle.size) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }
}
