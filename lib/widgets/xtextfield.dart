import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/app_theme.dart';

class XTextField extends StatefulWidget {
  final TextEditingController controller;
  final Color prefixIconColor;
  final String hintText;
  final IconData prefixIcon;
  final Widget suffixIcon;
  final bool obscureText;
  final ValueChanged<String> onChanged;

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
        prefixIcon: Consumer<AppTheme>(
          builder: (context, appTheme, child) {
            return Icon(
              widget.prefixIcon,
              color: hasFocus
                  ? appTheme.themeColor
                  : Theme.of(context).textTheme.body2.color,
            );
          },
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
