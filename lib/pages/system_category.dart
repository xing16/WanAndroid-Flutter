import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/system_category.dart';
import 'package:wanandroid_flutter/pages/system_article_list.dart';
import 'package:wanandroid_flutter/res/colors.dart';

class SystemCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SystemCategoryPageState();
  }
}

class SystemCategoryPageState extends State<SystemCategoryPage> {
  double screenWidth = 0;
  double leftMenuWidth = 100;
  double leftMenuRightMargin = 8;

  // 左侧 ListView 数据源
  List<SystemCategory> systemCategoryList = new List();

  // 右侧 GridView 数据源
  List<SystemCategory> contentSystemList = new List();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadSystemCategory();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 8,
              bottom: 8,
              right: leftMenuRightMargin,
            ),
            decoration: ShapeDecoration(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
            ),
            width: leftMenuWidth,
            padding: EdgeInsets.only(
              right: 5,
            ),
            child: getSystemListView(),
          ),
          Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: screenWidth - leftMenuWidth - leftMenuRightMargin * 2,
                  child: getGridView(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 创建左侧 ListView
  getSystemListView() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print("ontap = $systemCategoryList");
            setState(() {
              selectedIndex = index;
              contentSystemList = systemCategoryList[index].children;
            });
          },
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  left: 16,
                ),
                height: 50,
                child: Text(
                  systemCategoryList[index].name,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    color: (index == selectedIndex)
                        ? Colours.appThemeColor
                        : Theme.of(context).textTheme.body1.color,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 13,
                child: Visibility(
                  visible: selectedIndex == index,
                  child: Container(
                    height: 24,
                    width: 6,
                    color: Colours.appThemeColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          indent: 12,
          height: 0.5,
        );
      },
      itemCount: systemCategoryList.length,
    );
  }

  /// 创建右侧网格布局
  getGridView() {
    return GridView.custom(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return getGridItem(index);
        },
        childCount: contentSystemList.length,
      ),
    );
  }

  getGridItem(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SystemArticleListPage(
                contentSystemList[index].id, contentSystemList[index].name),
          ),
        );
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          left: 10,
        ),
        child: Text(
          contentSystemList[index].name,
          style: TextStyle(
            fontSize: 16,
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  void loadSystemCategory() {
    HttpClient.getInstance().get(Api.SYSTEM_CATEGORY, callback: (data) {
      if (data is List) {
        List<SystemCategory> list =
            data.map((map) => SystemCategory.fromJson(map)).toList();
        contentSystemList = list[selectedIndex].children;
        setState(() {
          if (mounted) {
            systemCategoryList = list;
          }
        });
      }
    });
  }
}
