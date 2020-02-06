import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/http/api.dart';
import 'package:wanandroid_flutter/http/http.dart';
import 'package:wanandroid_flutter/provider/app_theme.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';
import 'package:wanandroid_flutter/widgets/xtextfield.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  double screenWidth = 0;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  TextEditingController repwdController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        // 拦截返回键,避免页面先关闭，再关闭软键盘
        FocusScope.of(context).unfocus();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: GradientAppBar(
          title: Text("注册"),
        ),
        body: Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: XTextField(
                  usernameController,
                  "用户名",
                  prefixIcon: Icons.person,
                  obscureText: false,
                  suffixIcon: Icon(
                    Icons.close,
                    color: Theme.of(context).textTheme.button.color,
                  ),
                  onChanged: (text) {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 16,
                ),
                child: XTextField(
                  pwdController,
                  "密码",
                  prefixIcon: Icons.lock,
                  suffixIcon: Icon(
                    Icons.close,
                    color: Theme.of(context).textTheme.button.color,
                  ),
                  onChanged: (text) {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 16,
                ),
                child: XTextField(
                  repwdController,
                  "确认密码",
                  prefixIcon: Icons.lock,
                  suffixIcon: Icon(
                    Icons.close,
                    color: Theme.of(context).textTheme.button.color,
                  ),
                  onChanged: (text) {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                ),
                child: Consumer<AppTheme>(
                  builder: (context, provider, child) {
                    return MaterialButton(
                      elevation: 0,
                      onPressed: () {
                        register();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      height: 46,
                      minWidth: screenWidth,
                      color: provider.themeColor,
                      child: Text(
                        "注册",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    String username = usernameController.text;
    String password = pwdController.text;
    String repassword = repwdController.text;
    if (username.isEmpty) {
      Fluttertoast.showToast(msg: "请输入用户名");
      return;
    }
    if (password.isEmpty || repassword.isEmpty) {
      Fluttertoast.showToast(msg: "请输入密码");
      return;
    }
    if (password != repassword) {
      Fluttertoast.showToast(msg: "两次密码不一致");
      return;
    }
    await HttpClient.getInstance().post(Api.USER_REGISTER, data: {
      "username": username,
      "password": password,
      "repassword": repassword
    });
    Fluttertoast.showToast(msg: "注册成功");
    Navigator.of(context).pop();
  }
}
