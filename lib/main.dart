import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid_flutter/pages/main_page.dart';
import 'package:wanandroid_flutter/provider/app_theme.dart';
import 'package:wanandroid_flutter/provider/login_state.dart';
import 'package:wanandroid_flutter/res/colors.dart';

import 'provider/dark_mode.dart';
import 'res/theme_colors.dart';

void main() {
  final appTheme = new AppTheme();
  final darkMode = new DarkMode();
  final loginState = new LoginState();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appTheme),
        ChangeNotifierProvider.value(value: darkMode),
        ChangeNotifierProvider.value(value: loginState),
      ],
      child: MyApp(),
    ),
  );
  queryThemeColor().then((index) {
    appTheme.updateThemeColor(getThemeColors()[index]);
  });

  // 设置状态栏和 appbar 颜色一致
  if (Platform.isAndroid) {
    var systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

queryDark(DarkMode darkMode) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool isDark = sp.getBool("dark") ?? false;
  darkMode.setDark(isDark);
}

queryThemeColor() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  int themeColorIndex = sp.getInt("themeColorIndex") ?? 0;
  return themeColorIndex;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<AppTheme>(context);
    var darkMode = Provider.of<DarkMode>(context);
    return MaterialApp(
      title: 'WanAndroid',
      debugShowCheckedModeBanner: false,
      theme: getTheme(appTheme.themeColor, isDarkMode: darkMode.isDark),
      home: MainPage(),
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
      indicatorColor: Colors.white,
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
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        // 一级文本
        body1: isDarkMode
            ? TextStyle(
                color: Colours.darkAppText,
              )
            : TextStyle(
                color: Colours.appText,
              ),
//        subtitle: isDarkMode
//            ? TextStyle(color: Colors.amber)
//            : TextStyle(color: Colors.cyan),
        // 二级文本
        body2: isDarkMode
            ? TextStyle(
                color: Colours.darkAppSubText,
                fontSize: 14,
              )
            : TextStyle(
                color: Colours.appSubText,
                fontSize: 14,
              ),
        display1: isDarkMode
            ? TextStyle(color: Colours.darkAppActionClip)
            : TextStyle(color: Colours.appActionClip),
        button: TextStyle(color: isDarkMode ? Colors.white30 : Colors.black54),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode ? Colours.darkAppDivider : Colours.appDivider,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode ? Colours.darkAppDivider : Colours.appDivider,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode ? Colours.darkAppDivider : Colours.appDivider,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor:
            isDarkMode ? Colours.darkDialogBackground : Colors.white,
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
}
