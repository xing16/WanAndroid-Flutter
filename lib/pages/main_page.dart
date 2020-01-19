import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/pages/home_page.dart';
import 'package:wanandroid_flutter/pages/mine_page.dart';
import 'package:wanandroid_flutter/pages/project_page.dart';
import 'package:wanandroid_flutter/pages/system_page.dart';
import 'package:wanandroid_flutter/provider/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid_flutter/res/theme_colors.dart';
import 'package:wanandroid_flutter/provider/dark_mode.dart';

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
    queryThemeColor().then((index) {
      Provider.of<AppTheme>(context).updateThemeColor(getThemeColors()[index]);
    });
    queryDark().then((value) {
      Provider.of<DarkMode>(context).setDark(value);
    });
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
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  void onNavigationItemSelected(int value) {
    setState(() {
      this.mCurrentIndex = value;
    });
  }

  /// 查询主题色
  queryThemeColor() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int themeColorIndex = sp.getInt("themeColorIndex") ?? 0;
    return themeColorIndex;
  }

  /// 查询暗黑模式
  queryDark() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isDark = sp.getBool("dark") ?? false;
    return isDark;
  }
}
