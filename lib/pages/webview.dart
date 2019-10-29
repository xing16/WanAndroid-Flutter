import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage({this.url, this.title});

  @override
  State<StatefulWidget> createState() {
    return WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {
  List<Map<String, Object>> list = new List();

  @override
  void initState() {
    super.initState();
    list
      ..add({"title": "收藏", "icon": Icons.favorite_border})
      ..add({"title": "复制链接", "icon": Icons.link})
      ..add({"title": "浏览器打开", "icon": Icons.open_in_browser})
      ..add({"title": "微信分享", "icon": Icons.share})
      ..add({"title": "微信分享", "icon": Icons.star});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详情"),
        titleSpacing: 1,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              // 显示底部弹框
              _showBottomSheet(context);
            },
            child: Container(
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          controller.canGoBack().then((res) {
            print(res);
          });
          controller.currentUrl().then((url) {
            print(url);
          });
        },
        onPageFinished: (String url) {
          print("onPageFinished");
        },
      ),
    );
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 260,
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          color: Colours.appBackground,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (BuildContext context, int index) {
              return createBottomSheetItem(
                  list[index]['title'], list[index]['icon'], (index) {
                handleBottomSheetItemClick(index);
              });
            },
            itemCount: list.length,
          ),
        );
      },
    );
  }

  createBottomSheetItem(String title, IconData icon, Function onClick) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: Colours.appThemeColor,
              size: 40,
            ),
          ),
          Text(
            title,
            maxLines: 1,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void handleBottomSheetItemClick(index) {}
}
