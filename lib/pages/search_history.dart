import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/hot_search.dart';
import 'package:wanandroid_flutter/widgets/header_list_view.dart';

class SearchHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchHistoryPageState();
  }
}

class SearchHistoryPageState extends State<SearchHistoryPage> {
  double screenWidth = 0;
  List<HotSearch> hotSearchList = new List();
  List<String> searchHistoryList = new List();

  @override
  void initState() {
    super.initState();
    searchHistoryList
      ..add("dcd")
      ..add("dcd")
      ..add("dcd")
      ..add("dcd")
      ..add("dcd")
      ..add("dcd");
    loadHotSearch();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return HeaderListView(
      searchHistoryList,
      headerList: [1],
      headerBuilder: (BuildContext context, int position) {
        return Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  bottom: 15,
                ),
                child: Text(
                  "热门搜索",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Wrap(
                spacing: 14,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: createWrapItems(),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 16,
                ),
                child: Text(
                  "搜索历史",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemBuilder: (BuildContext context, int position) {
        return Container(
          height: 50,
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "我爱你",
                style: TextStyle(fontSize: 16),
              ),
              Icon(
                Icons.close,
                color: Colors.black54,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          indent: 12,
          endIndent: 12,
          height: 1,
        );
      },
    );
  }

  void loadHotSearch() {
    HttpClient.getInstance().get(Api.SEARCH_HOT, callback: (data) {
      if (data is List) {
        setState(() {
          hotSearchList = data.map((map) => HotSearch.fromJson(map)).toList();
        });
      }
    });
  }

  List<Widget> createWrapItems() =>
      List.generate(hotSearchList.length, (index) {
        return GestureDetector(
            onTap: () {
              onSearchHotClick(hotSearchList[index].name);
            },
            child: Container(
              height: 30,
              padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xaadddddd),
                border: Border.all(
                  color: Color(0xccaaaaaa),
                  width: 0.5,
                ),
                shape: BoxShape.rectangle,
              ),
              child: Text(
                hotSearchList[index].name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ));
      });

  // 热门搜索项点击
  void onSearchHotClick(String name) {}
}
