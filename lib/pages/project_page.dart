import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/models/project_tab.dart';
import 'package:wanandroid_flutter/pages/project_list_page.dart';
import 'package:wanandroid_flutter/provider/app_theme.dart';

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
    var appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          child: AppBar(
            titleSpacing: 0,
            title: Row(
              children: <Widget>[
                Expanded(
                  child: TabBar(
                    labelPadding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 2,
                    ),
//                    indicatorPadding: EdgeInsets.all(0),
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
                appTheme.themeColor,
                appTheme.themeColor,
              ],
            ),
          ),
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          50,
        ),
      ),
      body: TabBarView(
        controller: mController,
        children: createTabPage(),
      ),
    );
  }

  List<Widget> createTabPage() {
    List<Widget> widgets = new List();
    for (var projectTab in tabList) {
      widgets.add(ProjectListPage(projectTab.id));
    }
    return widgets;
  }

  @override
  void dispose() {
    super.dispose();
    if (mounted) {
      mController.dispose();
    }
  }

  /// 请求 tabs
  void loadTabs(int page) async {
    var result = await HttpClient.getInstance().get(Api.PROJECT_TABS);
    if (result is List) {
      if (mounted) {
        for (var value in result) {
          ProjectTab tab = ProjectTab.fromJson(value);
          tabList.add(tab);
        }
        setState(() {
          mController = TabController(
            length: tabList.length,
            vsync: this,
          );
        });
      }
    }
  }
}
