import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/models/hot_search.dart';
import 'package:wanandroid_flutter/pages/search_history.dart';
import 'package:wanandroid_flutter/pages/search_result_page.dart';
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
  TextEditingController controller = new TextEditingController();
  bool showClose = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        title: Container(
          margin: EdgeInsets.only(
            right: 5,
            left: 5,
          ),
          child: TextField(
            controller: controller,
            cursorColor: Colors.white,
            onChanged: (String value) {
              setState(() {
                showClose = value.length > 0;
              });
            },
            decoration: InputDecoration(
              hintText: "输入关键字搜索",
              hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.white38,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  controller.text = "";
                },
                child: Visibility(
                  visible: showClose,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            textInputAction: TextInputAction.search,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        centerTitle: true,
        colors: [
          Colours.appThemeColor,
          Color(0xfffa5650),
        ],
      ),
      body: (controller.text == null || controller.text.isEmpty)
          ? SearchHistoryPage(SearchPage())
          : SearchResultPage(controller.text),
    );
  }
}
