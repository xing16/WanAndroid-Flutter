import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  List<Meizi> meiziList = new List();
  int pageSize = 20;
  int curPage = 1;
  RefreshController _refreshController = new RefreshController();
  List heights = [260, 310, 200, 250, 290];

  @override
  void initState() {
    super.initState();
    mScroller = new ScrollController();
    _loadRefresh();
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
          child: StaggeredGridView.countBuilder(
            // 滑动控制器
            controller: mScroller,
            // 滑动方向
            scrollDirection: Axis.vertical,
            // 纵轴方向被划分的个数
            crossAxisCount: 2,
            itemCount: meiziList.length,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            staggeredTileBuilder: (index) {
              return StaggeredTile.fit(1);
            },
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _onItemClick(meiziList, index);
                },
                child: Container(
                  //随机生成高度
                  height: (heights[index % heights.length]).toDouble(),
                  width: 20,
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage("images/placeholder.png"),
                    image: NetworkImage(meiziList[index].url),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _loadMeizi(int pageSize, int page) async {
    var result = await HttpClient.getInstance()
        .get(Api.GANK_MEIZI, data: {"pageSize": pageSize, "page": page});
    curPage = page + 1;
    return result;
  }

  @override
  void dispose() {
    super.dispose();
    mScroller?.dispose();
  }

  /// item 点击事件
  void _onItemClick(List<Meizi> meizis, int index) {
    List<String> urls = new List();
    meizis.forEach((meizi) {
      urls.add(meizi.url);
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ImagePreviewPage(urls, index),
      ),
    );
  }

  void _loadRefresh() async {
    var result = await _loadMeizi(pageSize, 0);
    setState(() {
      meiziList.clear();
      meiziList.addAll(result.map((map) => Meizi.fromJson(map)).toList());
    });
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  void _loadMore() async {
    var result = await _loadMeizi(pageSize, curPage);
    setState(() {
      meiziList.addAll(result.map((map) => Meizi.fromJson(map)).toList());
    });
    _refreshController.loadComplete();
  }
}
