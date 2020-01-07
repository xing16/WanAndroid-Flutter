import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/meizi.dart';
import 'package:wanandroid_flutter/pages/image_preview_page.dart';
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
  EasyRefreshController _refreshController = new EasyRefreshController();
  List heights = [260, 310, 200, 250, 290];

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
        child: EasyRefresh(
          controller: _refreshController,
          header: ClassicalHeader(),
          footer: ClassicalFooter(
            noMoreText: "到底了",
          ),
          onRefresh: () async {
            loadMeizi(pageSize, 0);
          },
          onLoad: () async {
            loadMeizi(pageSize, curPage);
          },
          child: StaggeredGridView.countBuilder(
            // 滑动控制器
            controller: mScroller,
            // 滑动方向
            scrollDirection: Axis.vertical,
            // 纵轴方向被划分的个数
            crossAxisCount: 2,
            itemCount: meizis.length,
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
                  height: (heights[index % heights.length]).toDouble(),
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
      ),
    );
  }

  void loadMeizi(int pageSize, int page) async {
    var result = await HttpClient.getInstance()
        .get(Api.GANK_MEIZI, data: {"pageSize": pageSize, "page": page});
    curPage = page + 1;
    if (result is List) {
      setState(() {
        if (page == 0) {
          meizis.clear();
        }
        meizis.addAll(result.map((map) => Meizi.fromJson(map)).toList());
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    mScroller.dispose();
  }

  /// item 点击事件
  void _onItemClick(Meizi meizi) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ImagePreviewPage(),
      ),
    );
  }
}
