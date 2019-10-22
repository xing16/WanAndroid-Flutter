import 'package:flutter/material.dart';
import 'system_category_page.dart';
import 'system_square_page.dart';

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
      appBar: TabBar(
        controller: mController,
        // 选中颜色
        labelColor: Colors.white,
        // 选中样式
        labelStyle: TextStyle(fontSize: 20),
        // 未选中颜色
        unselectedLabelColor: Colors.white70,
        // 未选中样式
        unselectedLabelStyle: TextStyle(fontSize: 16),
        // 是否可滑动
        isScrollable: true,
        // 指示器宽度
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.white,
        // tab 标签
        tabs: list.map((title) {
          return Tab(
            child: Container(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          );
        }).toList(),
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
