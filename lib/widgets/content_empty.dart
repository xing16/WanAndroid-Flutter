import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.hourglass_empty,
        ),
        Text(
          "无内容",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
