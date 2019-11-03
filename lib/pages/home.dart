import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:banner/banner.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/banner.dart';
import 'package:wanandroid_flutter/models/home_response.dart';
import 'package:wanandroid_flutter/pages/webview.dart';
import 'package:wanandroid_flutter/res/colors.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Article> dataList = new List();

  List<HomeBanner> banners = new List();
  ScrollController mController = new ScrollController();
  double appBarOpacity = 0;

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
    _loadHomeArticles();
//    _loadBanner();
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
              child: ListView.separated(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return getHomeHeader();
                  }
                  return getHomePageItem(context, index - 1);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    indent: 12,
                    endIndent: 12,
                    height: 0.5,
                  );
                },
                controller: mController,
                itemCount: dataList.length,
              ),
            ),
            Opacity(
              opacity: appBarOpacity,
              child: Container(
                padding: EdgeInsets.only(
                  top: 30,
                ),
                height: 80,
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
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Text(
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
      // item 点击事件
      onTap: () {
        _onItemClick(context, index); //处理点击事件
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(12),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              dataList[index].title,
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
                    visible: dataList[index].fresh,
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
                      dataList[index].author.isEmpty
                          ? dataList[index].shareUser
                          : dataList[index].author,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      dataList[index].niceDate,
                      style: TextStyle(),
                    ),
                    margin: EdgeInsets.only(left: 20),
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
    return new BannerView(
      data: ['a', 'b', 'c'],
      height: 180,
      buildShowView: (index, data) {
        return Container(
          child: FadeInImage.assetNetwork(
            placeholder: "",
            image:
                "https://upload-images.jianshu.io/upload_images/12650374-f114b55f0ae20ec4.png?imageMogr2/auto-orient/strip|imageView2/2/w/700/format/webp",
            fit: BoxFit.cover,
          ),
        );
      },
      onBannerClickListener: (index, data) {
        print(index);
      },
    );
  }

  _loadHomeArticles() {
    HttpClient.getInstance().get(Api.HOME_ARTICLE, (data) {
      HomeArticleResponse response = HomeArticleResponse.fromJson(data);
      setState(() {
        dataList = response.datas;
      });
    });
  }

  _loadBanner() {
    HttpClient.getInstance().get(Api.BANNER, (data) {
      setState(() {
        banners = data;
      });
    });
  }

  /// item 点击事件
  _onItemClick(BuildContext context, int position) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => WebViewPage(
          url: dataList[position].link,
        ),
      ),
    );
  }
}
