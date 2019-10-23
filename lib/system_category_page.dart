import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
//    return Container(
//      decoration: ShapeDecoration(
//        color: Colors.white,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.only(
//            topRight: Radius.circular(10),
//            bottomRight: Radius.circular(10),
//          ),
//        ),
//      ),
//      child: getSystemListView(),
//      margin: EdgeInsets.only(
//        top: 10,
//      ),
//    );

    return Container(
      color: Color(0xfff0f0f0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 8,
              bottom: 8,
              right: leftMenuRightMargin,
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
            width: leftMenuWidth,
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

  /// 创建 ListView
  getSystemListView() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16),
              height: 50,
              child: Text(
                "性能优化",
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 13,
              child: Offstage(
                offstage: index != 0,
                child: Container(
                  height: 24,
                  width: 6,
                  child: null,
                ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            left: 12,
          ),
          color: Colors.black12,
          height: 0.5,
        );
      },
      itemCount: 60,
    );
  }

  ///
  getGridView() {
    return GridView.custom(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, position) {
          return getGridItem();
        },
      ),
    );
  }

  getGridItem() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: 10,
      ),
      child: Text(
        "内存优化",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
