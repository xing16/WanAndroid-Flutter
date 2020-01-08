import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wanandroid_flutter/models/article.dart';
import 'package:wanandroid_flutter/pages/webview_page.dart';
import 'package:wanandroid_flutter/widgets/article_item.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavoritePageState();
  }
}

class FavoritePageState extends State<FavoritePage> {
  double screenWidth = 0;
  List<Article> articleList = new List();
  List<String> list = new List();

  @override
  void initState() {
    super.initState();
    list.add("casd");
    list.add("casd");
    list.add("casd");
    list.add("casd");
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("收藏"),
      ),
      body: EasyRefresh(
        header: ClassicalHeader(),
        footer: ClassicalFooter(
          noMoreText: "到底了",
        ),
        onRefresh: () async {},
        onLoad: () async {},
        child:
//        HeaderListView(
//          list,
//          headerList: [1],
//          headerBuilder: (BuildContext context, int position) {
//            return Image(
//              image: AssetImage("images/avatar.jpeg"),
//            );
//          },
//          itemBuilder: (BuildContext context, int position) {
//            return Text("casdc");
//          },
//          separatorBuilder: (context, index) {
//            return Divider(
//              indent: 12,
//              endIndent: 12,
//              height: 0.5,
//            );
//          },
//        ),

            ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (index < 1) {
              return header(context);
            }
            int itemIndex = index - 1;
            return item(context, itemIndex);
          },
          separatorBuilder: (context, index) {
            return Divider(
              indent: 12,
              endIndent: 12,
              height: 0.5,
            );
          },
          itemCount: 20,
        ),
//            Container(
//          height: 300,
//          color: Colors.redAccent,
//        ),
      ),
    );
  }

  getFavoriteListItem(BuildContext context, int index) {
    Article article = articleList[index];
    return ArticleItem(
      article.title,
      article.niceDate,
      article.shareUser,
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => WebViewPage(
              url: article.link,
            ),
          ),
        );
      },
    );
  }

  Widget item(BuildContext context, int itemIndex) {
    return Container(
      height: 50,
      child: Text("casdcasc"),
    );
  }

  Widget header(BuildContext context) {
    return Image(
      image: AssetImage("images/avatar.jpeg"),
    );
  }
}
