import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/pages/search.dart';
import 'package:wanandroid_flutter/res/colors.dart';

import 'system_category.dart';
import 'system_square.dart';

class SystemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SystemPageState();
  }
}

class SystemPageState extends State<SystemPage>
    with SingleTickerProviderStateMixin {
  double screenWidth = 0;
  TabController mController;
  List<String> list = new List<String>();

  @override
  void initState() {
    super.initState();
    list..add("体系")..add("广场");
    mController = TabController(
      length: list.length,
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
            titleSpacing: 5,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return SearchPage();
                      },
                    ),
                  );
                },
              ),
            ],
            title: Row(
              children: <Widget>[
                Expanded(
                  child: TabBar(
                    labelPadding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 5,
                    ),
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
                    tabs: list.map((title) {
                      return Tab(
                        child: Container(
                          padding: EdgeInsets.all(0),
                          child: Text(title),
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
          50,
        ),
      ),
      body: TabBarView(
        controller: mController,
        children: <Widget>[
          SystemCategoryPage(),
          SystemSquarePage(),
        ],
      ),
    );
  }
}
