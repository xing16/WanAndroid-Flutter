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
      height: 60,
      padding: EdgeInsets.only(
        left: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "1111",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text("222"),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                ),
                child: Text("222"),
              ),
            ],
          ),
        ],
      ),
      color: Colors.red,
    );
  }
}
