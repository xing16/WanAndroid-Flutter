import 'package:flutter/material.dart';

/// 显示软键盘
/// __focusNode 为 TextField 的 FocusNode 属性
void showKeyboard(BuildContext context, FocusNode _focusNode) {
  if (MediaQuery.of(context).viewInsets.bottom == 0) {
    final focusScope = FocusScope.of(context);
    focusScope.requestFocus(FocusNode());
    Future.delayed(Duration.zero, () => focusScope.requestFocus(_focusNode));
  }
}

/// 隐藏软键盘
void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}
