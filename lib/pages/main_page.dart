import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/pages/mine_page.dart';
import 'package:wanandroid_flutter/pages/project_page.dart';
import 'package:wanandroid_flutter/pages/system_page.dart';
import 'package:wanandroid_flutter/pages/home_page.dart';
import 'package:wanandroid_flutter/provider/app_theme.dart';
import 'package:wanandroid_flutter/provider/login_state.dart';
import 'package:provider/provider.dart';

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
