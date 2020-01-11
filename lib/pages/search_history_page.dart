import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/hot_search.dart';
import 'package:wanandroid_flutter/pages/search_page.dart';
import 'package:wanandroid_flutter/widgets/header_list_view.dart';

class SearchHistoryPage extends StatefulWidget {
  final SearchPage searchPage;

  SearchHistoryPage(this.searchPage);

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
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                spacing: 10,
                runSpacing: 0,
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
          color: Theme.of(context).accentColor,
          height: 50,
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "我爱你",
                style: TextStyle(fontSize: 16),
              ),
              Icon(
                Icons.close,
                color: Theme.of(context).textTheme.button.color,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        if (index > 0) {
          return Divider(
            indent: 12,
            endIndent: 12,
            height: 1,
          );
        } else {
          return Text(
            "",
            style: TextStyle(fontSize: 0),
          );
        }
      },
    );
  }

  void loadHotSearch() async {
    var result = await HttpClient.getInstance().get(Api.SEARCH_HOT);
    if (result is List) {
      setState(() {
        hotSearchList = result.map((map) => HotSearch.fromJson(map)).toList();
      });
    }
  }

  List<Widget> createWrapItems() =>
      List.generate(hotSearchList.length, (index) {
        return ActionChip(
          backgroundColor: Theme.of(context).textTheme.display1.color,
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          label: Text(
            hotSearchList[index].name,
            style: TextStyle(
              color: Theme.of(context).textTheme.body1.color,
            ),
          ),
          onPressed: () {
            onSearchHotClick(hotSearchList[index].name);
          },
        );
      });

// 热门搜索项点击
  void onSearchHotClick(String name) {}
}
