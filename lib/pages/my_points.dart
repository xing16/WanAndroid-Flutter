import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/item_creator.dart';

class MyPointsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyPointsPageState();
  }
}

class MyPointsPageState extends State<MyPointsPage> {
  double screenWidth = 0;
  List<String> list = new List();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 20; i++) {
      list.add("data = $i");
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: GradientAppBar.create(
        context,
        Colours.appThemeColor,
        Color(0xfffa5650),
        title: "我的积分(406)",
      ),
      body: ListView.separated(
//        physics: BouncingScrollPhysics(),
//        physics: AlwaysScrollableScrollPhysics(),
//        physics: FixedExtentScrollPhysics(),
        physics: PageScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return getHeader();
          }
          return getItem(context, index + 2);
        },
        separatorBuilder: (context, index) {
          return Divider(
            indent: 60,
            endIndent: 60,
            height: 0,
          );
        },
        itemCount: list.length,
      ),
    );
  }

  Widget getHeader() {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 250,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colours.appThemeColor,
                Color(0xfffa5650),
              ],
            ),
          ),
        ),
        Image(
          width: 200,
          alignment: Alignment.topCenter,
          fit: BoxFit.contain,
          image: AssetImage("images/trophy.png"),
        ),
//        Container(
//          alignment: Alignment.topCenter,
//          margin: EdgeInsets.only(
////            top: 20,
////            top: -20,
//              ),
//          height: 170,
//          decoration: BoxDecoration(
//            image: DecorationImage("images/trophy.png",
//              fit: BoxFit.fitHeight,
//              image: AssetImage(),
//            ),
//          ),
//        ),
        Positioned(
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              getTopItem(160, "小红", 1, AssetImage("images/avatar.jpeg")),
              getTopItem(
                  170,
                  "小黑",
                  0,
                  NetworkImage(
                      "https://user-gold-cdn.xitu.io/2019/1/9/168329d14a4d9f35")),
              getTopItem(150, "小红", 2, AssetImage("images/avatar.jpeg")),
            ],
          ),
        ),
      ],
    );
  }

  Widget getItem(BuildContext context, int index) {
    return Container(
      color: Theme.of(context).accentColor,
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: index == list.length + 1 ? 20 : 0,
      ),
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            (index + 1).toString(),
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            index.toString(),
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            "tomcat",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            "209",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget getTopItem(
      double height, String name, int index, ImageProvider avatar) {
    return Container(
      height: height,
      width: (MediaQuery.of(context).size.width - 30) / 3,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          topLeft: index != 2 ? Radius.circular(6) : Radius.circular(0),
          topRight: index != 1 ? Radius.circular(6) : Radius.circular(0),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: avatar,
                radius: 36,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "1002",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(
                left: 50,
              ),
              alignment: Alignment.center,
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == 0 ? Colors.red : Colors.amber,
              ),
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
