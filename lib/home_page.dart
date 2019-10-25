import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:banner/banner.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView.separated(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return getHomeHeader();
                }
                return getHomePageItem(index - 1);
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
              itemCount: 60),
          Offstage(
            offstage: true,
            child: Container(
              height: 80,
              child: AppBar(
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 首页普通 item
  getHomePageItem(int index) {
    return GestureDetector(
        // item 点击事件
        onTap: () {
          onItemClick(index); //处理点击事件
        },
        child: Container(
          padding: EdgeInsets.all(12),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "我是 title",
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
                        "置顶",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                        border: Border.all(
                          color: Colors.red,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "xing16",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      margin: EdgeInsets.only(left: 20),
                    ),
                    Container(
                      child: Text(
                        "2019-09-11",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      margin: EdgeInsets.only(left: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  /// 首页 header
  getHomeHeader() {
    print("casdcasdc");
    return new BannerView(
      data: ['a', 'b', 'c'],
      height: 200,
      buildShowView: (index, data) {
        return Container(
          child: FadeInImage.assetNetwork(
            placeholder: "",
            image:
                "https://upload-images.jianshu.io/upload_images/12650374-f114b55f0ae20ec4.png?imageMogr2/auto-orient/strip|imageView2/2/w/700/format/webp",
            fit: BoxFit.cover,
          ),
        );
      },
      onBannerClickListener: (index, data) {
        print(index);
      },
    );
  }

  /// item 点击事件
  onItemClick(int position) {
    Navigator.pushNamed(context, "login");
  }
}
