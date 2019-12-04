import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/home_article.dart';
import 'package:wanandroid_flutter/models/home_banner.dart';
import 'package:wanandroid_flutter/pages/search_page.dart';
import 'package:wanandroid_flutter/pages/webview_page.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/utils/screen_utils.dart';
import 'package:wanandroid_flutter/widgets/header_list_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Article> articles = new List();
  List<HomeBanner> banners = new List();
  ScrollController mController = new ScrollController();
  double appBarOpacity = 0;
  int curPage = 0;

  @override
  void initState() {
    super.initState();
    mController.addListener(() {
      double opacity = mController.offset / 150;
      print("opacity = $opacity");
      if (opacity < 0.0) {
        opacity = 0.0;
      } else if (opacity > 1.0) {
        opacity = 1.0;
      }
      setState(() {
        appBarOpacity = opacity;
      });
    });
    loadBanner();
    loadHomeArticles(curPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: HeaderListView(
                articles,
                headerList: [1],
                headerBuilder: (BuildContext context, int position) {
                  return getHomeHeader();
                },
                itemBuilder: (BuildContext context, int position) {
                  return getHomePageItem(context, position);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    indent: 12,
                    endIndent: 12,
                    height: 0.5,
                  );
                },
                controller: mController,
              ),
            ),
            Opacity(
              opacity: appBarOpacity,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                height: ScreenUtils.getStatusBarHeight() + 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colours.appThemeColor,
                      Color(0xfffa5650),
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
                              return SearchPage();
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
  getHomePageItem(BuildContext context, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // item 点击事件
      onTap: () {
        onArticleItemClick(context, index); //处理点击事件
      },
      child: Container(
        padding: EdgeInsets.all(12),
        color: Theme.of(context).accentColor,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              articles[index].title,
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
                    visible: articles[index].fresh,
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
                      articles[index].author.isEmpty
                          ? articles[index].shareUser
                          : articles[index].author,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      articles[index].niceDate,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
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
  getHomeHeader() {
    return Container(
      height: 200,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            banners[index].imagePath,
            fit: BoxFit.cover,
          );
        },
        itemCount: banners.length,
        pagination: new SwiperPagination(
          alignment: Alignment.bottomRight,
          builder: SwiperPagination.dots,
        ),
        autoplay: true,
        onTap: (int index) {
          onBannerItemClick(banners[index].url);
        },
      ),
    );
  }

  loadHomeArticles(int page) {
    HttpClient.getInstance().get(Api.HOME_ARTICLE, data: {"page": page},
        callback: (data) {
      HomeArticle homeArticle = HomeArticle.fromJson(data);
      List<Article> articles = homeArticle.datas;
      print("articles = $articles");
      setState(() {
        this.articles = articles;
        curPage++;
      });
    });
  }

  loadBanner() {
    HttpClient.getInstance().get(Api.BANNER, callback: (data) {
      print("data ===== bnner === $data");
      if (data is List) {
        setState(() {
          banners = data.map((map) => HomeBanner.fromJson(map)).toList();
        });
      }
    });
  }

  /// item 点击事件
  void onArticleItemClick(BuildContext context, int position) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => WebViewPage(
          url: articles[position].link,
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
}
