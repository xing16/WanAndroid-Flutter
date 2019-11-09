import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/project_article.dart';
import 'package:wanandroid_flutter/models/project_tab.dart';
import 'package:wanandroid_flutter/res/colors.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProjectPageState();
  }
}

class ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin {
  TabController mController;
  List<ProjectTab> tabList = new List();
  List<Article> articleList = new List();
  double screenWidth = 0;
  int curPage = 0;

  @override
  void initState() {
    super.initState();
    loadTabs(curPage);
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
    for (var projectTab in tabList) {
      widgets.add(getProjectListView(projectTab.id));
    }
    return widgets;
  }

  /// 创建 ListView
  getProjectListView(int tabId) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return getProjectListItem(tabId, index);
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
  getProjectListItem(int tabId, int position) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          FadeInImage.assetNetwork(
            placeholder: "images/placeholder.png",
            width: 90,
            height: 66,
            image: articleList[position].envelopePic,
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
                            articleList[position].title,
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
                          articleList[position].author,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(articleList[position].niceDate),
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

  void loadTabs(int page) {
    HttpClient.getInstance().get(Api.PROJECT_TABS, (data) {
      if (data is List) {
        setState(() {
          tabList = data.map((map) => ProjectTab.fromJson(map)).toList();
          loadProjectsList(tabList[0].id, page);
          mController = TabController(
            length: tabList.length,
            vsync: this,
          );
        });
      }
    });
  }

  void loadProjectsList(int tabId, int page) {
    HttpClient.getInstance().get(Api.PROJECT_LIST, (data) {
      ProjectArticle projectArticle = ProjectArticle.fromJson(data);
      setState(() {
        articleList = projectArticle?.datas;
      });
    });
  }
}
