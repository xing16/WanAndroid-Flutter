import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    var duration = new Duration(seconds: 3);
    new Future.delayed(duration, gotoMainPage);
  }

  void gotoMainPage() {
    Navigator.of(context).pushReplacementNamed('main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
