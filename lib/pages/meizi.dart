import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';

class MeiziPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MeiziPageState();
  }
}

class MeiziPageState extends State<MeiziPage> {
  double screenWidth = 0;
  ScrollController mScroller = new ScrollController();

  @override
  void initState() {
    super.initState();
    mScroller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar.create(
        context,
        Colours.appThemeColor,
        Color(0xfffa5650),
        title: "妹子",
      ),
      body: Container(
        child: StaggeredGridView.countBuilder(
          // 滑动控制器
          controller: mScroller,
          // 滑动方向
          scrollDirection: Axis.vertical,
          // 纵轴方向被划分的个数
          crossAxisCount: 2,
          itemCount: 20,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          staggeredTileBuilder: (index) {
            return StaggeredTile.fit(1);
          },
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _onItemClick(index);
              },
              child: Container(
                color: Colors.green,
                //随机生成高度
                height: 150 + Random().nextInt(10) * 20.0,
                width: 20,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage("images/avatar_def.png"),
                  image: NetworkImage(
                      "https://user-gold-cdn.xitu.io/2019/1/9/168329d14a4d9f35"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    mScroller.dispose();
  }

  /// item 点击事件
  void _onItemClick(int index) {
    print(index);
  }
}
