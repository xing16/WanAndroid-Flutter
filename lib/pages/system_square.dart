import 'package:flutter/material.dart';

class SystemSquarePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SystemSquarePageState();
  }
}

class SystemSquarePageState extends State<SystemSquarePage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return getSystemSquareItem(index);
        },
        separatorBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            color: Colors.black12,
            height: 0.5,
          );
        },
        itemCount: 60);
  }

  getSystemSquareItem(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "我承认我自卑 我真的很怕黑,每到黑夜来临的时候我总很狼,我彻夜在买醉 但我不曾后悔只是想让自己清楚为什么掉眼泪",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "222",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "222",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      color: Colors.green,
    );
  }
}
