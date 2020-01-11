import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/provider/app_theme_provider.dart';
import 'package:wanandroid_flutter/models/my_points.dart';
import 'package:wanandroid_flutter/models/own_points.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/circle_degree_ring.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/header_list_view.dart';

class MyPointsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyPointsPageState();
  }
}

class MyPointsPageState extends State<MyPointsPage>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  double ownPointsCount = 6000;
  int maxPointsCount = 4000;
  double screenWidth = 0;
  List<UserPoints> pointsList = new List();
  int curPage = 0;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    animation =
        new Tween(begin: 0.0, end: ownPointsCount).animate(animationController)
          ..addListener(() {
//        setState(() {});
          });
    loadPointsRanking(curPage);
    loadOwnPoint();
  }

  startAnimation() {
    animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    var appTheme = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("积分"),
        colors: [
          Colours.appThemeColor,
          Color(0xfffa5650),
        ],
      ),
      body: HeaderListView(
        pointsList,
        headerList: [1],
        headerBuilder: (BuildContext context, int position) {
          return getHeader(appTheme.themeColor);
        },
        itemBuilder: (BuildContext context, int position) {
          return getItem(context, position);
        },
        separatorBuilder: (context, index) {
          return Divider(
            indent: 60,
            endIndent: 60,
            height: 0,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController?.dispose();
  }

  Widget getHeader(Color color) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [color, color],
            ),
          ),
        ),
        AnimationCirclePointsWidget(maxPointsCount, animation),
        Positioned(
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
//              getTopItem(150, pointsList[0].username, pointsList[0].coinCount,
//                  1, AssetImage("images/avatar.jpeg")),
//              getTopItem(
//                  150,
//                  pointsList[1].username,
//                  pointsList[1].coinCount,
//                  0,
//                  NetworkImage(
//                      "https://user-gold-cdn.xitu.io/2019/1/9/168329d14a4d9f35")),
//              getTopItem(150, pointsList[2].username, pointsList[2].coinCount,
//                  2, AssetImage("images/avatar.jpeg")),
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
            flex: 2,
            child: getRankNumber(index),
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

  Widget getRankNumber(int index) {
    if (index == 0 || index == 1) {
      return Container(
        alignment: Alignment.center,
        height: 22,
        width: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == 0 ? Colors.red : Colors.amber,
        ),
        child: Text(
          (index + 1).toString(),
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).accentColor,
          ),
        ),
      );
    }
    return Container(
      alignment: Alignment.center,
      child: Text(
        (index + 1).toString(),
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget createTopItem(double height, String name, int coinCount, int index,
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
  void loadPointsRanking(int page) async {
    var result = await HttpClient.getInstance()
        .get(Api.POINTS_RANK, data: {"page": page});
    startAnimation();
    MyPoints myPoints = MyPoints.fromJson(result);
    setState(() {
      pointsList = myPoints?.datas;
    });
  }

  /// 获取自己的积分
  void loadOwnPoint() async {
    var result = await HttpClient.getInstance().get(Api.POINTS_OWN);
    if (result != null) {
      print("loadOwnPoint = $result");
      OwnPoints ownPoints = OwnPoints.fromJson(result);
      setState(() {
        ownPointsCount = ownPoints?.coinCount?.toDouble();
      });
    }
  }
}

class AnimationCirclePointsWidget extends AnimatedWidget {
  final Animation<double> animation;
  final int maxPointsCount;

  AnimationCirclePointsWidget(this.maxPointsCount, this.animation, {Key key})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(220, 220),
        painter: CircleDegreeRing(animation.value.toInt(), maxPointsCount),
      ),
    );
  }
}
