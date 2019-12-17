import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid_flutter/pages/home_page.dart';
import 'package:wanandroid_flutter/pages/login_page.dart';
import 'package:wanandroid_flutter/pages/mine_page.dart';
import 'package:wanandroid_flutter/pages/project_page.dart';
import 'package:wanandroid_flutter/pages/system_page.dart';
import 'package:wanandroid_flutter/res/colors.dart';

import 'models/app_theme.dart';

void main() {
  runApp(new ChangeNotifierProvider(
    create: (context) => AppTheme(),
    child: MyApp(),
  ));
  // 设置状态栏和 appbar 颜色一致
  if (Platform.isAndroid) {
    var systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<AppTheme>(context);
    queryDark(appTheme);
    return MaterialApp(
      title: 'WanAndroid',
      debugShowCheckedModeBanner: false,
      theme: getTheme(appTheme.themeColor, isDarkMode: appTheme.isDark),
      home: MainPage(),
      routes: {
        "login": (BuildContext context) => LoginPage(),
        "main": (BuildContext context) => MainPage(),
      },
    );
  }

  getTheme(Color themeColor, {bool isDarkMode = false}) {
    return ThemeData(
//      primarySwatch: MaterialColor()Colours.appThemeColor,
      // 页面背景颜色
      scaffoldBackgroundColor:
          isDarkMode ? Colours.darkAppBackground : Colours.appBackground,
      backgroundColor: isDarkMode ? Colours.darkAppBackground : Colors.white,
      // tab 指示器颜色
      indicatorColor: Colours.appThemeColor,
      accentColor:
          isDarkMode ? Colours.darkAppForeground : Colours.appForeground,
      // 底部菜单背景颜色
      bottomAppBarColor:
          isDarkMode ? Colours.darkAppForeground : Colours.appForeground,
      primaryColor: Colours.appThemeColor,
      primaryColorDark: Colours.appBackground,
//      brightness: isDarkMode ? Brightness.light : Brightness.dark,
      ///  appBar theme
      appBarTheme: AppBarTheme(
        color: Colors.yellow,
        // 状态栏字体颜色
        brightness: Brightness.dark,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        body1: isDarkMode
            ? TextStyle(color: Colours.darkAppText)
            : TextStyle(color: Colours.appText),
//        subtitle: isDarkMode
//            ? TextStyle(color: Colors.amber)
//            : TextStyle(color: Colors.cyan),

        body2: TextStyle(color: Colors.cyan),
        button: TextStyle(color: Colors.orange),
        subtitle: TextStyle(color: Colors.green),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFBDBDBD),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFBDBDBD),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFBDBDBD),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: isDarkMode ? Colours.darkAppBackground : Colors.white,
        titleTextStyle: TextStyle(
          color: isDarkMode ? Colours.darkAppText : Colours.appText,
          fontSize: 20,
        ),
        contentTextStyle: TextStyle(
          color: Colors.yellow,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor:
            isDarkMode ? Colours.darkAppBackground : Colours.appBackground,
      ),
      dividerColor: isDarkMode ? Colours.darkAppDivider : Colours.appDivider,
      cursorColor: Colours.appThemeColor,
      bottomAppBarTheme: BottomAppBarTheme(
        color: isDarkMode ? Colours.darkAppForeground : Colours.appForeground,
      ),
      toggleButtonsTheme: ToggleButtonsThemeData(color: Colors.yellow),
    );
  }

  queryDark(AppTheme appTheme) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isDark = sp.getBool("dark") ?? false;
    print("main isDark = $isDark");
    appTheme.setDark(isDark);
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
    var appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      body: IndexedStack(
        index: mCurrentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(
          color: appTheme.themeColor,
        ),
        unselectedIconTheme: IconThemeData(
//          color: Colors.black54,
            ),
        selectedFontSize: 14,
        elevation: 50,
        unselectedFontSize: 14,
        selectedItemColor: appTheme.themeColor,
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
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  void onNavigationItemSelected(int value) {
    setState(() {
      this.mCurrentIndex = value;
    });
  }
}
