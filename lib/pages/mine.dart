import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/pages/settings.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/bezier_clipper.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/item_creator.dart';

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
      appBar: GradientAppBar.create(
        context,
        Colours.appThemeColor,
        Color(0xfffa5650),
        title: "我的",
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
                            color: Theme.of(context).accentColor,
                            child: Stack(
                              children: <Widget>[
                                // 贝塞尔背景
                                ClipPath(
                                  clipper: BezierClipper(),
                                  child: Container(
                                    height: 180,
                                    width: screenWidth,
                                    decoration: new BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colours.appThemeColor,
                                          Color(0xfffa5650),
                                        ],
                                      ),
                                    ),
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
                                                "images/avatar_def.png",
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
                              ItemCreator.createItem(
                                context,
                                Icons.favorite,
                                "收藏",
                                () {
                                  print("ddd");
                                },
                                margin: EdgeInsets.only(top: 20),
                              ),
                              ItemCreator.createItem(
                                context,
                                Icons.color_lens,
                                "主题颜色",
                                () {
                                  print("ddd");
                                },
                                margin: EdgeInsets.only(top: 20),
                                hasDivider: true,
                              ),
                              ItemCreator.createItem(
                                context,
                                Icons.beach_access,
                                "干货妹子",
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return SettingsPage();
                                      },
                                    ),
                                  );
                                },
                                hasDivider: true,
                              ),
                              ItemCreator.createItem(
                                context,
                                Icons.settings,
                                "设置",
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return SettingsPage();
                                      },
                                    ),
                                  );
                                },
                                hasDivider: false,
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
}
