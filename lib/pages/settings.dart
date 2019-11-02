import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/item_creator.dart';

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
      appBar: GradientAppBar.create(
        context,
        Colours.appThemeColor,
        Color(0xfffa5650),
        title: "设置",
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 0,
            ),
            margin: EdgeInsets.only(
              top: 30,
            ),
            color: Theme.of(context).accentColor,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 52,
                ),
                Positioned(
                  child: Switch(
                      activeColor: Colours.appThemeColor,
                      inactiveTrackColor: Theme.of(context).accentColor,
                      value: isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = !isDarkMode;
                        });
                      }),
                  right: 0,
                ),
                Positioned(
                  child: Icon(
                    Icons.brightness_6,
                    color: Colours.appThemeColor,
                    size: 22,
                  ),
                  top: 16,
                ),
                Positioned(
                  child: Text(
                    "夜间模式",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  left: 36,
                  top: 14,
                ),
              ],
            ),
          ),
          ItemCreator.createItem(
            context,
            Icons.delete_forever,
            "清除缓存",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SettingsPage();
                  },
                ),
              );
            },
            margin: EdgeInsets.only(
              top: 20,
            ),
            hasDivider: true,
          ),
          ItemCreator.createItem(
            context,
            Icons.language,
            "语言设置",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SettingsPage();
                  },
                ),
              );
            },
            hasDivider: true,
            showMore: false,
          ),
          ItemCreator.createItem(
            context,
            Icons.account_box,
            "关于",
            () {
              print("ddd");
            },
          ),
          Container(
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.only(
              left: 20,
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 40,
              bottom: 40,
            ),
            child: Text(
              "退出登录",
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            height: 52,
            width: screenWidth,
          ),
        ],
      ),
    );
  }
}
