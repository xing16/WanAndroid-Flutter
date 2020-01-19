import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanandroid_flutter/pages/main_page.dart';
import 'package:wanandroid_flutter/provider/app_theme.dart';
import 'package:wanandroid_flutter/provider/dark_mode.dart';
import 'package:wanandroid_flutter/provider/login_state.dart';
import 'package:wanandroid_flutter/res/colors.dart';

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
    var darkMode = Provider.of<DarkMode>(context);
    // 全局配置子树下的SmartRefresher,下面列举几个特别重要的属性
    return RefreshConfiguration(
      // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
      headerBuilder: () => WaterDropHeader(),
      // 配置默认底部指示器
      footerBuilder: () => ClassicFooter(
        loadingText: "上拉加载更多",
      ),
      // 头部触发刷新的越界距离
      headerTriggerDistance: 60.0,
      // 自定义回弹动画,三个属性值意义请查询flutter api
      springDescription:
          SpringDescription(stiffness: 120, damping: 16, mass: 1.9),
      //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
      maxOverScrollExtent: 60,
      // 底部最大可以拖动的范围
      maxUnderScrollExtent: 0,
      //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
      enableScrollWhenRefreshCompleted: true,
      //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
      enableLoadingWhenFailed: true,
      // Viewport不满一屏时,禁用上拉加载更多功能
      hideFooterWhenNotFull: true,
      // 可以通过惯性滑动触发加载更多
      enableBallisticLoad: true,
      child: MaterialApp(
        localizationsDelegates: [
          // 这行是关键
          RefreshLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('zh'),
        ],
        localeResolutionCallback:
            (Locale locale, Iterable<Locale> supportedLocales) {
          //print("change language");
          return locale;
        },
        title: 'WanAndroid',
        debugShowCheckedModeBanner: false,
        theme: getTheme(appTheme.themeColor, isDarkMode: darkMode.isDark),
        home: MainPage(),
      ),
    );
  }

  getTheme(Color themeColor, {bool isDarkMode = false}) {
    return ThemeData(
      // 页面背景颜色
      scaffoldBackgroundColor:
          isDarkMode ? Colours.darkAppBackground : Colours.appBackground,
      accentColor: isDarkMode ? Colours.darkAppSubText : Colours.appSubText,
      // tab 指示器颜色
      indicatorColor: Colors.white,
      backgroundColor:
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
