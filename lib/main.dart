import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanandroid_flutter/pages/home.dart';
import 'package:wanandroid_flutter/pages/login.dart';
import 'package:wanandroid_flutter/pages/mine.dart';
import 'package:wanandroid_flutter/pages/project.dart';
import 'package:wanandroid_flutter/pages/system.dart';
import 'package:wanandroid_flutter/res/colors.dart';

void main() {
  runApp(MyApp());
  // 设置状态栏和 appbar 颜色一致
  if (Platform.isAndroid) {
    var systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getTheme(isDarkMode: false),
      home: MainPage(),
      routes: {
        "login": (BuildContext context) => LoginPage(),
        "main": (BuildContext context) => MainPage(),
      },
    );
  }

  getTheme({bool isDarkMode = false}) {
    return ThemeData(
//      primarySwatch: MaterialColor()Colours.appThemeColor,
      // 页面背景颜色
      scaffoldBackgroundColor:
          isDarkMode ? Colours.darkAppBackground : Colours.appBackground,
      backgroundColor:
          isDarkMode ? Colours.darkAppBackground : Colours.appBackground,
      // tab 指示器颜色
      indicatorColor: Colours.appThemeColor,
      accentColor: isDarkMode ? Colours.darkApp : Colours.app,

      // 底部菜单背景颜色
      bottomAppBarColor:
          isDarkMode ? Colours.darkAppBackground : Colours.appBackground,
      primaryColor: Colours.appThemeColor,
      primaryColorDark: Colours.appBackground,
//      brightness: isDarkMode ? Brightness.light : Brightness.dark,
      // appBar 背景颜色
      appBarTheme: AppBarTheme(
//        color: Colours.appThemeColor,
        // 状态栏字体颜色
        brightness: isDarkMode ? Brightness.light : Brightness.dark,
      ),
      textTheme: TextTheme(
        body1: isDarkMode
            ? TextStyle(color: Colours.darkAppText)
            : TextStyle(color: Colours.appText),
        subtitle: isDarkMode
            ? TextStyle(color: Colors.amber)
            : TextStyle(color: Colors.cyan),
      ),
      dialogTheme: DialogTheme(
        backgroundColor:
            isDarkMode ? Colours.darkAppBackground : Colours.appBackground,
        titleTextStyle: TextStyle(
          color: isDarkMode ? Colours.darkAppText : Colours.appText,
          fontSize: 20,
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor:
            isDarkMode ? Colours.darkAppBackground : Colours.appBackground,
      ),
      dividerColor: isDarkMode ? Colours.darkAppDivider : Colours.appDivider,
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int mCurrentIndex = 0;
  List<Widget> pages = new List<Widget>();

  @override
  void initState() {
    super.initState();
    pages
      ..add(HomePage())
      ..add(ProjectPage())
      ..add(SystemPage())
      ..add(MinePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: mCurrentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(
          color: Colours.appThemeColor,
        ),
        unselectedIconTheme: IconThemeData(
//          color: Colors.black54,
            ),
        selectedFontSize: 14,
        elevation: 20,
        unselectedFontSize: 14,
        selectedItemColor: Colours.appThemeColor,
        unselectedItemColor: Color(0xff555555),
        showUnselectedLabels: true,
        currentIndex: mCurrentIndex,
        onTap: onNavigationItemSelected,
        items: [
          createNavigationBarItem(
            context,
            "首页",
            Icon(Icons.home),
          ),
          createNavigationBarItem(
            context,
            "项目",
            Icon(Icons.store),
          ),
          createNavigationBarItem(
            context,
            "体系",
            Icon(Icons.apps),
          ),
          createNavigationBarItem(
            context,
            "我的",
            Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  createNavigationBarItem(BuildContext context, String content, Icon icon) {
    return BottomNavigationBarItem(
      title: new Text(
        content,
        style: TextStyle(fontSize: 12),
      ),
      icon: icon,
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  void onNavigationItemSelected(int value) {
    setState(() {
      this.mCurrentIndex = value;
    });
  }
}
