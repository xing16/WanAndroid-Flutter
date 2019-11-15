import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/models/my_points.dart';
import 'package:wanandroid_flutter/models/own_points.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/circle_degree_ring.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';

class MyPointsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyPointsPageState();
  }
}

class MyPointsPageState extends State<MyPointsPage>
    with TickerProviderStateMixin {
  double screenWidth = 0;
  List<UserPoints> pointsList = new List();
  int curPage = 0;
  AnimationController animationController;
  int ownPointsCount = 600;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animationController.forward();
    loadPointsRanking(curPage);
    loadOwnPoint();
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
        title: "积分",
      ),
      body: ListView.separated(
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
        itemCount: pointsList.length,
      ),
    );
  }

  Widget getHeader() {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 940,
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
//        Image(
//          width: 200,
//          alignment: Alignment.topCenter,
//          fit: BoxFit.contain,
//          image: AssetImage("images/trophy.png"),
//        ),

        Container(
          child: CustomPaint(
            size: Size(300, 360),
            painter: CircleDegreeRing(20),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              getTopItem(150, pointsList[0].username, pointsList[0].coinCount,
                  1, AssetImage("images/avatar.jpeg")),
              getTopItem(
                  150,
                  pointsList[1].username,
                  pointsList[1].coinCount,
                  0,
                  NetworkImage(
                      "https://user-gold-cdn.xitu.io/2019/1/9/168329d14a4d9f35")),
              getTopItem(150, pointsList[2].username, pointsList[2].coinCount,
                  2, AssetImage("images/avatar.jpeg")),
            ],
          ),
        ),
      ],
    );
  }

  Widget getItem(BuildContext context, int index) {
    print("index = $index");
    return Container(
      color: Theme.of(context).accentColor,
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: index == pointsList.length + 1 ? 20 : 0,
      ),
      padding: EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
                maxLines: 1,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${pointsList[index]?.level?.toString()}级",
                style: TextStyle(
                  fontSize: 18,
                ),
                maxLines: 1,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              alignment: Alignment.center,
              child: Text(
                pointsList[index].username,
                style: TextStyle(
                  fontSize: 18,
                ),
                maxLines: 1,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${pointsList[index].coinCount?.toString()} 分",
                style: TextStyle(
                  fontSize: 18,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTopItem(double height, String name, int coinCount, int index,
      ImageProvider avatar) {
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
                coinCount.toString(),
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

  /// 获取积分排行版
  void loadPointsRanking(int page) {
    HttpClient.getInstance().get(Api.POINTS_RANK, data: {"page": page},
        callback: (data) {
      MyPoints myPoints = MyPoints.fromJson(data);
      setState(() {
        pointsList = myPoints?.datas;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController?.dispose();
  }

  /// 获取自己的积分
  void loadOwnPoint() {
    HttpClient.getInstance().get(Api.POINTS_OWN, callback: (data) {
      OwnPoints ownPoints = OwnPoints.fromJson(data);
      setState(() {
        ownPointsCount = ownPoints?.coinCount;
      });
    });
  }
}
