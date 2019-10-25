import 'package:flutter/material.dart';

import 'widgets/bei_path.dart';
import 'widgets/bezier_clipper.dart';

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
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),
      body: Container(
        color: Color(0xfff5f5f5),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  // 贝塞尔背景
                  ClipPath(
                    clipper: BezierClipper(),
                    child: Container(
                      color: Colors.cyan,
                      height: 180,
                      width: screenWidth,
                    ),
                  ),
                  // 头像，名字
                  Positioned(
                    left: 32,
                    top: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: Image.network(
                            "https://user-gold-cdn.xitu.io/2019/1/9/168329d14a4d9f35",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
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
                Container(
                  margin: EdgeInsets.only(
                    top: 12,
                  ),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  width: screenWidth,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Text(
                    "收藏",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  width: screenWidth,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Text(
                    "收藏",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  width: screenWidth,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Text(
                    "收藏",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  width: screenWidth,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Text(
                    "收藏",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
