import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid_flutter/provider/app_theme_provider.dart';
import 'package:wanandroid_flutter/pages/about_page.dart';
import 'package:wanandroid_flutter/pages/login_page.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/section_item.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  double screenWidth = 0;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("设置"),
        colors: [
          Colours.appThemeColor,
          Color(0xfffa5650),
        ],
      ),
      body: Column(
        children: <Widget>[
          SectionItem(
            Icons.brightness_6,
            "夜间模式",
            margin: EdgeInsets.only(
              top: 20,
            ),
            right: Switch(
                activeColor: Provider.of<AppThemeProvider>(context).themeColor,
                value: Provider.of<AppThemeProvider>(context).isDark,
                onChanged: (value) {
                  print("value = $value");
                  Provider.of<AppThemeProvider>(context).switchTheme();
                  saveDarkMode(value);
                }),
            hasDivider: false,
          ),
          SectionItem(
            Icons.delete_forever,
            "清除缓存",
            callback: () {},
            margin: EdgeInsets.only(
              top: 20,
            ),
            showMore: false,
            hasDivider: true,
          ),
          SectionItem(Icons.language, "语言设置",
              callback: () {},
              hasDivider: true,
              right: Padding(
                padding: EdgeInsets.only(
                  right: 8,
                ),
                child: Text(
                  "中文",
                  style: TextStyle(fontSize: 16),
                ),
              )),
          SectionItem(
            Icons.account_box,
            "关于",
            callback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AboutPage();
                  },
                ),
              );
            },
            right: Icon(
              Icons.chevron_right,
              color: Theme.of(context).textTheme.button.color,
              size: 30,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 40,
              bottom: 40,
            ),
            child: MaterialButton(
              elevation: 0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              textColor: Colors.red,
              child: Text(
                "退出登录",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.redAccent,
                ),
              ),
              minWidth: screenWidth,
              height: 52,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }

  void saveDarkMode(bool value) async {
    print("dark  = $value");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("dark", value);
  }
}
