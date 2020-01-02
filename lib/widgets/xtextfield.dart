import 'package:flutter/material.dart';

class XTextField extends StatefulWidget {
  final TextEditingController controller;
  Color prefixIconColor;
  String hintText;
  IconData prefixIcon;
  Widget suffixIcon;
  GestureTapCallback onTap;
  bool obscureText;
  FocusNode focusNode;
  ValueChanged<String> onChanged;

  XTextField(
    this.controller,
    this.hintText, {
    this.prefixIcon,
    this.prefixIconColor,
    this.obscureText = false,
    this.suffixIcon,
    this.focusNode,
    this.onTap,
    this.onChanged,
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
      obscureText: widget.obscureText,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      //是否是密码
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
          onTap: widget.onTap,
          child: widget.suffixIcon,
        ),
      ),
    );
  }
}
