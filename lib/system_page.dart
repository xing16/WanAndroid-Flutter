import 'package:flutter/material.dart';

class SystemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SystemPageState();
  }
}

class SystemPageState extends State<SystemPage> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 120,
            child: getSystemListView(),
          ),
          Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: screenWidth - 120,
                  child: getGridView(),
                  color: Colors.green,
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
              padding: EdgeInsets.only(left: 22),
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
              child: Container(
                height: 24,
                width: 6,
                color: Colors.red,
                child: null,
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
        "casdcasd",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      color: Colors.red,
    );
  }
}
