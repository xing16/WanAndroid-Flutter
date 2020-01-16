import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/pages/about_page.dart';
import 'package:wanandroid_flutter/pages/login_page.dart';
import 'package:wanandroid_flutter/provider/app_theme.dart';
import 'package:wanandroid_flutter/provider/login_state.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/section_item.dart';
import 'package:wanandroid_flutter/provider/dark_mode.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  double screenWidth = 0;
  bool isDarkMode = false;
  bool cookieExist = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
//    isCookieExist().then((value) {
//      setState(() {
//        Provider.of<LoginState>(context).updateLoginState(value ?? false);
//        print("cookieExist 8888888888   = $cookieExist");
//      });
//    });
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
                activeColor: Provider.of<AppTheme>(context).themeColor,
                value: Provider.of<DarkMode>(context).isDark,
                onChanged: (value) {
                  print("value = $value");
                  Provider.of<DarkMode>(context).setDark(value);
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
            child: Consumer<LoginState>(
              builder: (context, provider, child) {
                return MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    handleLogoutBtnClick(context, provider);
                  },
                  textColor: Colors.red,
                  child: Text(
                    provider.loggedIn ? "退出登录" : "未登录, 点击登录",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.redAccent,
                    ),
                  ),
                  minWidth: screenWidth,
                  height: 52,
                  color: Theme.of(context).accentColor,
                );
              },
            ),
            margin: EdgeInsets.only(
              top: 40,
              bottom: 40,
            ),
          ),
        ],
      ),
    );
  }

  void handleLogoutBtnClick(BuildContext context, LoginState loginState) {
    /// 已经登录了，清除 cookie
    if (loginState.loggedIn) {
      removeUsernamePasswordCache();
      loginState.updateLoginState(false);
      Navigator.pop(context);
    } else {
      /// 没有登录，跳到登录页面
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginPage();
          },
        ),
      );
    }
  }

  void saveDarkMode(bool value) async {
    print("dark  = $value");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("dark", value);
  }
}

/// 清除 cookie 缓存
void removeUsernamePasswordCache() async {
  HttpClient.getInstance().persistCookieJar.deleteAll();
}
