import 'package:flutter/material.dart';

class XTextField extends StatefulWidget {
  final TextEditingController controller;
  Color prefixIconColor;
  String hintText;
  IconData prefixIcon;
  IconData suffixIcon;
  GestureTapCallback callback;
  bool obscureText;

  XTextField(
    this.controller,
    this.hintText, {
    this.prefixIcon,
    this.prefixIconColor,
    this.obscureText = false,
    this.suffixIcon,
    this.callback,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    return XTextFieldState();
  }
}

class XTextFieldState extends State<XTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText, //是否是密码
      style: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(
          widget.prefixIcon,
        ),
        prefixStyle: TextStyle(
          color: Colors.black87,
        ),
        suffixIcon: GestureDetector(
          onTap: widget.callback,
          child: Container(
            child: Icon(
              widget.suffixIcon,
              size: 22,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
