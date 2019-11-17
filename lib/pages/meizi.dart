import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/meizi.dart';
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
  ScrollController mScroller;

  List<Meizi> meizis = new List();
  int pageSize = 20;
  int curPage = 1;

  @override
  void initState() {
    super.initState();
    mScroller = new ScrollController();
    loadMeizi(pageSize, curPage);
    mScroller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("妹子"),
        colors: [
          Colours.appThemeColor,
          Color(0xfffa5650),
        ],
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
                _onItemClick(meizis[index]);
              },
              child: Container(
                //随机生成高度
                height: 150 + Random().nextInt(10) * 20.0,
                width: 20,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage("images/placeholder.png"),
                  image: NetworkImage(meizis[index].url),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void loadMeizi(int pageSize, int page) {
    HttpClient.getInstance().get(Api.GANK_MEIZI,
        data: {"pageSize": pageSize, "page": page}, callback: (data) {
      print("meizi ------- $data");
      if (data is List) {
        setState(() {
          meizis = data.map((map) => Meizi.fromJson(map)).toList();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    mScroller.dispose();
  }

  /// item 点击事件
  void _onItemClick(Meizi meizi) {}
}
