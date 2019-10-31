import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/res/colors.dart';

import '../widgets/bezier_clipper.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("我的"),
        centerTitle: true,
      ),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.only(
                right: 0.1,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Stack(
                              children: <Widget>[
                                // 贝塞尔背景
                                ClipPath(
                                  clipper: BezierClipper(),
                                  child: Container(
                                    color: Colours.appThemeColor,
                                    height: 180,
                                    width: screenWidth,
                                  ),
                                ),
                                // 头像，名字
                                Positioned(
                                  left: 32,
                                  top: 40,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ClipOval(
                                        child: FadeInImage.assetNetwork(
                                            placeholder:
                                                "images/android_logo.jpg",
                                            image:
                                                "https://user-gold-cdn.xitu.io/2019/1/9/168329d14a4d9f35",
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 16,
                                        ),
                                        child: Text(
                                          "星火燎原",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              createMineItem(
                                Icons.favorite,
                                "收藏",
                                () {
                                  print("ddd");
                                },
                                margin: EdgeInsets.only(top: 20),
                              ),
                              createMineItem(
                                Icons.settings,
                                "主题颜色",
                                () {
                                  print("ddd");
                                },
                                margin: EdgeInsets.only(top: 20),
                                hasDivider: true,
                              ),
                              createMineItem(
                                Icons.account_box,
                                "关于",
                                () {
                                  print("ddd");
                                },
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 20,
                                ),
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                  top: 40,
                                ),
                                child: Text(
                                  "退出登录",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                                height: 50,
                                width: screenWidth,
                              ),
                            ],
                          )
                        ],
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

  createMineItem(IconData icon, String text, GestureTapCallback callback,
      {EdgeInsetsGeometry margin, bool hasDivider = false}) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.centerLeft,
        margin: margin,
        padding: EdgeInsets.only(
          left: 15,
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 50,
                ),
                Positioned(
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.black45,
                    size: 30,
                  ),
                  top: 12,
                  right: 0,
                ),
                Positioned(
                  child: Icon(
                    icon,
                    color: Colours.appThemeColor,
                    size: 22,
                  ),
                  top: 16,
                ),
                Positioned(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  left: 36,
                  top: 14,
                ),
              ],
            ),
            Visibility(
              visible: hasDivider,
              child: Divider(
                indent: 30,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
