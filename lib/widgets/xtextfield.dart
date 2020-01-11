import 'package:flutter/material.dart';

class XTextField extends StatefulWidget {
  final TextEditingController controller;
  Color prefixIconColor;
  String hintText;
  IconData prefixIcon;
  Widget suffixIcon;
  bool obscureText;

  ValueChanged<String> onChanged;

  XTextField(
    this.controller,
    this.hintText, {
    this.prefixIcon,
    this.prefixIconColor,
    this.obscureText = true,
    this.suffixIcon,
    this.onChanged,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    return XTextFieldState();
  }
}

class XTextFieldState extends State<XTextField> {
  bool hasClearIcon = false;
  FocusNode focusNode = new FocusNode();
  bool hasFocus = false;

  @override
  Widget build(BuildContext context) {
    focusNode.addListener(() {
      print("hasFocus = ${focusNode.hasFocus}");
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    });
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      focusNode: focusNode,
      onChanged: (text) {
        widget.onChanged(text);
        setState(() {
          hasClearIcon = text.isNotEmpty;
        });
      },
      //是否是密码
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).textTheme.body1.color,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).textTheme.body1.color,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
//          color: Theme.of(context).textTheme.body1.color,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            widget.controller.clear();
            setState(() {
              hasClearIcon = false;
            });
          },
          child: hasClearIcon && hasFocus ? widget.suffixIcon : Text(""),
        ),
      ),
    );
  }
}
