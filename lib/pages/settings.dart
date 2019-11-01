import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/widgets/gradient_appbar.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar().create(context, "设置111"),
      body: Container(),
    );
  }
}
