import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/models/hot_search.dart';
import 'package:wanandroid_flutter/pages/search_history.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  double screenWidth = 0;
  List<HotSearch> hotSearchList = new List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("搜索"),
        centerTitle: true,
        colors: [
          Colours.appThemeColor,
          Color(0xfffa5650),
        ],
        actions: <Widget>[
          Icon(Icons.search),
        ],
      ),
      body: SearchHistoryPage(),
    );
  }
}
