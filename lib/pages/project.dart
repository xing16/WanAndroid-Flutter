import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/project_tab.dart';
import 'package:wanandroid_flutter/res/colors.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProjectPageState();
  }
}

class ProjectPageState extends State<ProjectPage>
    with SingleTickerProviderStateMixin {
  TabController mController;
  List<ProjectTab> tabList = new List();
  double screenWidth = 0;

  @override
  void initState() {
    super.initState();
    loadTabs();
    mController = TabController(
      length: tabList.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          child: AppBar(
            titleSpacing: 0,
            title: Row(
              children: <Widget>[
                Expanded(
                  child: TabBar(
                    labelPadding: EdgeInsets.all(14),
                    indicatorPadding: EdgeInsets.all(0),
                    // 选中颜色
                    labelColor: Colors.white,
                    // 选中样式
                    labelStyle: TextStyle(fontSize: 18),
                    // 未选中颜色
                    unselectedLabelColor: Colors.white70,
                    // 未选中样式
                    unselectedLabelStyle: TextStyle(fontSize: 16),
                    // 是否可滑动
                    isScrollable: true,
                    controller: mController,
                    // 指示器宽度
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.white,
                    // 相当于 indicator 高度
                    indicatorWeight: 3,
                    // tab 标签
                    tabs: tabList.map((tab) {
                      return Tab(
                        child: Container(
                          padding: EdgeInsets.all(0),
                          child: Text(tab.name),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
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
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          55,
        ),
      ),
      body: TabBarView(
        controller: mController,
        children: createTabPage(),
      ),
    );
  }

  createTabPage() {
    List<Widget> widgets = new List();
    for (var value in tabList) {
      widgets.add(getProjectListView());
    }
    return widgets;
  }

  /// 创建 ListView
  getProjectListView() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return getProjectListItem(index);
      },
      separatorBuilder: (context, index) {
        return Divider(
          indent: 12,
          endIndent: 12,
          height: 0.5,
        );
      },
      itemCount: 60,
    );
  }

  /// ListView item
  getProjectListItem(int position) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          FadeInImage.assetNetwork(
            placeholder: "images/placeholder.png",
            width: 90,
            height: 66,
            image:
                "https://upload-images.jianshu.io/upload_images/12650374-f114b55f0ae20ec4.png?imageMogr2/auto-orient/strip|imageView2/2/w/700/format/webp",
            fit: BoxFit.cover,
          ),
          Container(
            height: 66,
            width: screenWidth - 124,
            margin: EdgeInsets.only(
              left: 10,
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            "最新70城房价公布！北京、广州现大变化 领涨的竟是它！新建商品住宅销售价格环比涨幅微升，二手住宅销售价格涨幅基本持平。",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "author",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          "2222",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  void loadTabs() {
    HttpClient.getInstance().get(Api.PROJECT_TABS, (data) {
      if (data is List) {
        setState(() {
          tabList = data.map((map) => ProjectTab.fromJson(map)).toList();
          mController = TabController(
            length: tabList.length,
            vsync: this,
          );
        });
      }
    });
  }
}
